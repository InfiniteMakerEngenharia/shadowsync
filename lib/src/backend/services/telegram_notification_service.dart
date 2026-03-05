import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/telegram_notification_config.dart';
import 'notification_localizations.dart';

/// Tipos de evento para notificação
enum NotificationEventType {
  backupStarted,
  backupSuccess,
  backupFailure,
}

/// Resultado do envio de notificação
class NotificationResult {
  NotificationResult({
    required this.success,
    this.message,
    this.errorCode,
  });

  final bool success;
  final String? message;
  final int? errorCode;
}

/// Serviço para gerenciar notificações via Telegram Bot API.
class TelegramNotificationService {
  TelegramNotificationService._();

  static TelegramNotificationService? _instance;
  static const String _boxName = 'telegram_notification_config';
  static const String _configKey = 'config';
  static const String _telegramApiBaseUrl = 'https://api.telegram.org/bot';

  Box<TelegramNotificationConfig>? _box;
  final _configController = StreamController<TelegramNotificationConfig>.broadcast();

  /// Obtém a instância singleton do serviço
  static Future<TelegramNotificationService> getInstance() async {
    if (_instance == null) {
      _instance = TelegramNotificationService._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _box = await Hive.openBox<TelegramNotificationConfig>(_boxName);
  }

  /// Obtém a configuração atual
  TelegramNotificationConfig getConfig() {
    return _box?.get(_configKey) ?? TelegramNotificationConfig();
  }

  /// Stream para observar mudanças na configuração
  Stream<TelegramNotificationConfig> watchConfig() {
    Future.microtask(() => _configController.add(getConfig()));
    return _configController.stream;
  }

  /// Salva a configuração
  Future<void> saveConfig(TelegramNotificationConfig config) async {
    await _box?.put(_configKey, config);
    _configController.add(config);
  }

  /// Atualiza campos específicos da configuração
  Future<void> updateConfig({
    bool? isEnabled,
    String? botToken,
    String? chatId,
    bool? notifyOnSuccess,
    bool? notifyOnFailure,
    bool? notifyOnStart,
  }) async {
    final current = getConfig();
    final updated = current.copyWith(
      isEnabled: isEnabled,
      botToken: botToken,
      chatId: chatId,
      notifyOnSuccess: notifyOnSuccess,
      notifyOnFailure: notifyOnFailure,
      notifyOnStart: notifyOnStart,
    );
    await saveConfig(updated);
  }

  /// Envia uma notificação baseada no tipo de evento
  Future<NotificationResult> sendNotification({
    required NotificationEventType eventType,
    required String routineName,
    String? details,
    String? errorMessage,
    String? deviceName,
  }) async {
    final config = getConfig();
    
    final l10n = NotificationLocalizations.getInstance();

    if (!config.isConfigured) {
      return NotificationResult(
        success: false,
        message: l10n.configurationIncomplete,
      );
    }

    // Verifica se deve notificar para este tipo de evento
    final shouldNotify = switch (eventType) {
      NotificationEventType.backupStarted => config.notifyOnStart,
      NotificationEventType.backupSuccess => config.notifyOnSuccess,
      NotificationEventType.backupFailure => config.notifyOnFailure,
    };

    if (!shouldNotify) {
      return NotificationResult(
        success: true,
        message: l10n.notificationIgnored,
      );
    }

    final message = _buildMessage(eventType, routineName, details, errorMessage, deviceName, l10n);
    return await _sendToTelegram(config, message, l10n);
  }

  /// Envia uma mensagem de teste para verificar a configuração
  Future<NotificationResult> sendTestMessage({
    required String botToken,
    required String chatId,
  }) async {
    // Remove espaços e caracteres invisíveis da entrada
    final cleanBotToken = botToken.trim().replaceAll(RegExp(r'\s+'), '');
    final cleanChatId = chatId.trim().replaceAll(RegExp(r'\s+'), '');

    final config = TelegramNotificationConfig(
      isEnabled: true,
      botToken: cleanBotToken,
      chatId: cleanChatId,
    );

    final l10n = NotificationLocalizations.getInstance();
    final message = '🔔 *${_escapeMarkdown(l10n.telegramTestTitle)}*\n\n'
        '✅ ${_escapeMarkdown(l10n.telegramTestSuccess)}\n\n'
        '📅 ${_escapeMarkdown(l10n.labelDate)}: ${_formatDateTime(DateTime.now(), l10n)}';

    return await _sendToTelegram(config, message, l10n);
  }

  /// Obtém o chat ID do bot usando getUpdates
  /// Útil para ajudar o usuário a descobrir seu chat ID
  Future<String?> getLastChatId(String botToken) async {
    try {
      // Remove espaços e caracteres invisíveis
      final cleanToken = botToken.trim().replaceAll(RegExp(r'\s+'), '');
      final url = '$_telegramApiBaseUrl$cleanToken/getUpdates';
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 15),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['ok'] == true && data['result'] is List) {
          final results = data['result'] as List;
          if (results.isNotEmpty) {
            // Pega o último update
            final lastUpdate = results.last;
            final message = lastUpdate['message'] ?? lastUpdate['my_chat_member'];
            if (message != null && message['chat'] != null) {
              return message['chat']['id'].toString();
            }
          }
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Envia mensagem para a API do Telegram
  Future<NotificationResult> _sendToTelegram(
    TelegramNotificationConfig config,
    String message,
    NotificationLocalizations l10n,
  ) async {
    try {
      // Remove espaços, quebras de linha e caracteres invisíveis
      final botToken = (config.botToken ?? '').trim().replaceAll(RegExp(r'\s+'), '');
      final chatId = (config.chatId ?? '').trim().replaceAll(RegExp(r'\s+'), '');

      // DEBUG: Log dos valores
      debugPrint('[TelegramService] ========== DEBUG =========');
      debugPrint('[TelegramService] botToken length: ${botToken.length}');
      debugPrint('[TelegramService] botToken COMPLETO: $botToken');
      debugPrint('[TelegramService] botToken bytes: ${botToken.codeUnits}');
      debugPrint('[TelegramService] chatId: $chatId');
      debugPrint('[TelegramService] chatId length: ${chatId.length}');
      debugPrint('[TelegramService] chatId bytes: ${chatId.codeUnits}');

      if (botToken.isEmpty || chatId.isEmpty) {
        debugPrint('[TelegramService] ERRO: Token ou ChatID vazio!');
        return NotificationResult(
          success: false,
          message: l10n.invalidBotTokenOrChatId,
        );
      }

      final url = '$_telegramApiBaseUrl$botToken/sendMessage';
      debugPrint('[TelegramService] URL COMPLETA: $url');

      final bodyData = {
        'chat_id': chatId,
        'text': message,
        'parse_mode': 'MarkdownV2',
        'disable_web_page_preview': true,
      };
      debugPrint('[TelegramService] Body: ${json.encode(bodyData).replaceAll(botToken, "TOKEN_HIDDEN")}');

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bodyData),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Timeout ao conectar com Telegram');
        },
      );

      // DEBUG: Log da resposta
      debugPrint('[TelegramService] Response statusCode: ${response.statusCode}');
      debugPrint('[TelegramService] Response body: ${response.body}');
      debugPrint('[TelegramService] Response headers: ${response.headers}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        debugPrint('[TelegramService] Parsed data ok: ${data['ok']}');
        if (data['ok'] == true) {
          debugPrint('[TelegramService] SUCCESS!');
          return NotificationResult(
            success: true,
            message: l10n.messageSentSuccess,
          );
        } else {
          debugPrint('[TelegramService] API returned ok=false: ${data['description']}');
          return NotificationResult(
            success: false,
            message: l10n.errorWithDescription(data['description'] ?? 'Unknown'),
            errorCode: data['error_code'],
          );
        }
      } else {
        debugPrint('[TelegramService] HTTP Error: ${response.statusCode}');
        try {
          final data = json.decode(response.body);
          debugPrint('[TelegramService] Error description: ${data['description']}');
          return NotificationResult(
            success: false,
            message: data['description'] != null 
                ? l10n.errorWithDescription(data['description'])
                : l10n.httpError(response.statusCode),
            errorCode: response.statusCode,
          );
        } catch (e) {
          debugPrint('[TelegramService] Could not parse error body: $e');
          return NotificationResult(
            success: false,
            message: l10n.httpError(response.statusCode),
            errorCode: response.statusCode,
          );
        }
      }
    } on TimeoutException {
      debugPrint('[TelegramService] TIMEOUT!');
      return NotificationResult(
        success: false,
        message: l10n.connectionTimeout,
      );
    } on SocketException catch (e) {
      debugPrint('[TelegramService] SocketException: ${e.message}');
      return NotificationResult(
        success: false,
        message: l10n.connectionError(e.message),
      );
    } catch (e, stackTrace) {
      debugPrint('[TelegramService] Exception: $e');
      debugPrint('[TelegramService] StackTrace: $stackTrace');
      return NotificationResult(
        success: false,
        message: l10n.unexpectedError(e.toString()),
      );
    }
  }

  /// Constrói a mensagem de notificação baseada no evento
  String _buildMessage(
    NotificationEventType eventType,
    String routineName,
    String? details,
    String? errorMessage,
    String? deviceName,
    NotificationLocalizations l10n,
  ) {
    final timestamp = _formatDateTime(DateTime.now(), l10n);
    final escapedRoutineName = _escapeMarkdown(routineName);
    final escapedDeviceName = deviceName != null ? _escapeMarkdown(deviceName) : null;
    final buffer = StringBuffer();

    switch (eventType) {
      case NotificationEventType.backupStarted:
        buffer.writeln('🔄 *${_escapeMarkdown(l10n.backupStartedTitle)}*');
        buffer.writeln();
        buffer.writeln('📁 ${_escapeMarkdown(l10n.labelRoutine)}: $escapedRoutineName');
        if (escapedDeviceName != null) {
          buffer.writeln('💻 ${_escapeMarkdown(l10n.labelDevice)}: $escapedDeviceName');
        }
        buffer.writeln('📅 ${_escapeMarkdown(l10n.labelStartTime)}: $timestamp');
        
      case NotificationEventType.backupSuccess:
        buffer.writeln('✅ *${_escapeMarkdown(l10n.backupCompletedTitle)}*');
        buffer.writeln();
        buffer.writeln('📁 ${_escapeMarkdown(l10n.labelRoutine)}: $escapedRoutineName');
        if (escapedDeviceName != null) {
          buffer.writeln('💻 ${_escapeMarkdown(l10n.labelDevice)}: $escapedDeviceName');
        }
        buffer.writeln('📅 ${_escapeMarkdown(l10n.labelEndTime)}: $timestamp');
        if (details != null && details.isNotEmpty) {
          buffer.writeln('📊 ${_escapeMarkdown(l10n.labelDetails)}: ${_escapeMarkdown(details)}');
        }
        
      case NotificationEventType.backupFailure:
        buffer.writeln('❌ *${_escapeMarkdown(l10n.backupFailedTitle)}*');
        buffer.writeln();
        buffer.writeln('📁 ${_escapeMarkdown(l10n.labelRoutine)}: $escapedRoutineName');
        if (escapedDeviceName != null) {
          buffer.writeln('💻 ${_escapeMarkdown(l10n.labelDevice)}: $escapedDeviceName');
        }
        buffer.writeln('📅 ${_escapeMarkdown(l10n.labelTime)}: $timestamp');
        if (errorMessage != null && errorMessage.isNotEmpty) {
          buffer.writeln('⚠️ ${_escapeMarkdown(l10n.labelError)}: ${_escapeMarkdown(errorMessage)}');
        }
    }

    return buffer.toString();
  }

  /// Escapa caracteres especiais para MarkdownV2 do Telegram
  String _escapeMarkdown(String text) {
    const specialChars = r'_*[]()~`>#+-=|{}.!';
    var escaped = text;
    for (final char in specialChars.split('')) {
      escaped = escaped.replaceAll(char, '\\$char');
    }
    return escaped;
  }

  /// Formata data e hora para exibição
  String _formatDateTime(DateTime dateTime, NotificationLocalizations l10n) {
    final formattedDate = l10n.formatDateTime(dateTime);
    return _escapeMarkdown(formattedDate);
  }

  /// Fecha o serviço e libera recursos
  void dispose() {
    _configController.close();
  }
}
