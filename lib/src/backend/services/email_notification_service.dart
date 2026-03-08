import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../models/email_notification_config.dart';
import 'notification_localizations.dart';
import 'telegram_notification_service.dart' show NotificationEventType, NotificationResult;

/// Serviço para gerenciar notificações via Email SMTP.
class EmailNotificationService {
  EmailNotificationService._();

  static EmailNotificationService? _instance;
  static const String _boxName = 'email_notification_config';
  static const String _configKey = 'config';

  Box<EmailNotificationConfig>? _box;
  final _configController = StreamController<EmailNotificationConfig>.broadcast();

  /// Obtém a instância singleton do serviço
  static Future<EmailNotificationService> getInstance() async {
    if (_instance == null) {
      _instance = EmailNotificationService._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    _box = await Hive.openBox<EmailNotificationConfig>(_boxName);
  }

  /// Retorna a tag img com o ícone do app no cabeçalho do email
  String _getIconImgTag() {
    const iconUrl = 'https://shadownsyncwebpage.pages.dev/images/Email_Icon.png';
    return '<img src="$iconUrl" alt="ShadowSync" width="64" height="64" style="display: block; border: 0;" />';
  }

  /// Obtém a configuração atual
  EmailNotificationConfig getConfig() {
    return _box?.get(_configKey) ?? EmailNotificationConfig();
  }

  /// Stream para observar mudanças na configuração
  Stream<EmailNotificationConfig> watchConfig() {
    Future.microtask(() => _configController.add(getConfig()));
    return _configController.stream;
  }

  /// Salva a configuração
  Future<void> saveConfig(EmailNotificationConfig config) async {
    await _box?.put(_configKey, config);
    _configController.add(config);
  }

  /// Atualiza campos específicos da configuração
  Future<void> updateConfig({
    bool? isEnabled,
    String? smtpServer,
    int? smtpPort,
    String? senderEmail,
    String? senderPassword,
    List<String>? recipientEmails,
    bool? useSSL,
    bool? useTLS,
    bool? notifyOnSuccess,
    bool? notifyOnFailure,
    bool? notifyOnStart,
    String? presetName,
  }) async {
    final current = getConfig();
    final updated = current.copyWith(
      isEnabled: isEnabled,
      smtpServer: smtpServer,
      smtpPort: smtpPort,
      senderEmail: senderEmail,
      senderPassword: senderPassword,
      recipientEmails: recipientEmails,
      useSSL: useSSL,
      useTLS: useTLS,
      notifyOnSuccess: notifyOnSuccess,
      notifyOnFailure: notifyOnFailure,
      notifyOnStart: notifyOnStart,
      presetName: presetName,
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

    final subject = _buildSubject(eventType, routineName, l10n);
    final htmlContent = _buildHtmlContent(eventType, routineName, details, errorMessage, deviceName, l10n);
    
    return await _sendEmail(config, subject, htmlContent, l10n);
  }

  /// Envia um email de teste para verificar a configuração
  Future<NotificationResult> sendTestEmail({
    required String smtpServer,
    required int smtpPort,
    required String senderEmail,
    required String senderPassword,
    required List<String> recipientEmails,
    required bool useSSL,
    required bool useTLS,
  }) async {
    final config = EmailNotificationConfig(
      isEnabled: true,
      smtpServer: smtpServer,
      smtpPort: smtpPort,
      senderEmail: senderEmail,
      senderPassword: senderPassword,
      recipientEmails: recipientEmails,
      useSSL: useSSL,
      useTLS: useTLS,
    );

    final l10n = NotificationLocalizations.getInstance();
    final subject = l10n.emailSubjectTest;
    final htmlContent = _buildTestEmailHtml(l10n);

    return await _sendEmail(config, subject, htmlContent, l10n);
  }

  /// Cria o servidor SMTP com base na configuração
  SmtpServer _createSmtpServer(EmailNotificationConfig config) {
    final server = config.smtpServer ?? '';
    final port = config.smtpPort;
    final username = config.senderEmail ?? '';
    final password = config.senderPassword ?? '';

    if (config.useSSL) {
      return SmtpServer(
        server,
        port: port,
        ssl: true,
        username: username,
        password: password,
      );
    } else if (config.useTLS) {
      return SmtpServer(
        server,
        port: port,
        ssl: false,
        allowInsecure: false,
        username: username,
        password: password,
      );
    } else {
      return SmtpServer(
        server,
        port: port,
        ssl: false,
        allowInsecure: true,
        username: username,
        password: password,
      );
    }
  }

  /// Envia o email usando SMTP
  Future<NotificationResult> _sendEmail(
    EmailNotificationConfig config,
    String subject,
    String htmlContent,
    NotificationLocalizations l10n,
  ) async {
    try {
      final smtpServer = _createSmtpServer(config);

      final message = Message()
        ..from = Address(config.senderEmail ?? '', 'ShadowSync')
        ..recipients.addAll(config.recipientEmails)
        ..subject = subject
        ..html = htmlContent;

      final sendReport = await send(message, smtpServer);
      
      debugPrint('[EmailService] Email enviado: ${sendReport.toString()}');

      return NotificationResult(
        success: true,
        message: l10n.emailSentSuccess,
      );
    } on MailerException catch (e) {
      debugPrint('[EmailService] Erro ao enviar email: ${e.message}');
      
      String errorMessage = l10n.emailGenericError;
      
      // Trata erros comuns
      if (e.message.contains('Authentication')) {
        errorMessage = l10n.emailAuthenticationFailed;
      } else if (e.message.contains('Connection')) {
        errorMessage = l10n.emailConnectionFailed;
      } else if (e.message.contains('timeout')) {
        errorMessage = l10n.emailTimeoutError;
      } else if (e.message.contains('certificate')) {
        errorMessage = l10n.emailCertificateError;
      }

      return NotificationResult(
        success: false,
        message: errorMessage,
      );
    } catch (e) {
      debugPrint('[EmailService] Erro inesperado: $e');
      return NotificationResult(
        success: false,
        message: l10n.unexpectedError(e.toString()),
      );
    }
  }

  /// Constrói o assunto do email
  String _buildSubject(NotificationEventType eventType, String routineName, NotificationLocalizations l10n) {
    return switch (eventType) {
      NotificationEventType.backupStarted => '${l10n.emailSubjectBackupStarted}: $routineName',
      NotificationEventType.backupSuccess => '${l10n.emailSubjectBackupCompleted}: $routineName',
      NotificationEventType.backupFailure => '${l10n.emailSubjectBackupFailed}: $routineName',
    };
  }

  /// Constrói o conteúdo HTML do email
  String _buildHtmlContent(
    NotificationEventType eventType,
    String routineName,
    String? details,
    String? errorMessage,
    String? deviceName,
    NotificationLocalizations l10n,
  ) {
    final timestamp = l10n.formatDateTime(DateTime.now());
    
    final (icon, title, statusClass, statusColor) = switch (eventType) {
      NotificationEventType.backupStarted => ('🔄', l10n.backupStarted, 'started', '#2196F3'),
      NotificationEventType.backupSuccess => ('✅', l10n.backupCompleted, 'success', '#4CAF50'),
      NotificationEventType.backupFailure => ('❌', l10n.backupFailed, 'failure', '#f44336'),
    };

    final detailsSection = details != null && details.isNotEmpty
        ? '<p style="margin: 8px 0; color: #555; font-size: 14px; line-height: 1.5;"><strong style="color: #333;">• ${l10n.labelDetails}:</strong> $details</p>'
        : '';

    final errorSection = errorMessage != null && errorMessage.isNotEmpty
        ? '<p style="margin: 8px 0; color: #555; font-size: 14px; line-height: 1.5;"><strong style="color: #333;">• ${l10n.labelError}:</strong> $errorMessage</p>'
        : '';

    final deviceSection = deviceName != null && deviceName.isNotEmpty
        ? '<p style="margin: 8px 0; color: #555; font-size: 14px; line-height: 1.5;"><strong style="color: #333;">• ${l10n.labelDevice}:</strong> $deviceName</p>'
        : '';

    final iconTag = _getIconImgTag();

    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin: 0; padding: 0; background-color: #f5f5f5; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;">
  <table width="100%" cellpadding="0" cellspacing="0" style="max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <tr>
      <td style="background-color: #1e3a5f; padding: 28px 24px; text-align: center;">
        <table width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td align="center">
              $iconTag
            </td>
          </tr>
          <tr>
            <td align="center" style="padding-top: 12px;">
              <span style="font-size: 32px; font-weight: 800; color: #FFFFFF; display: block;">ShadowSync</span>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td style="padding: 24px; border-left: 4px solid $statusColor;">
        <h2 style="margin: 0 0 16px 0; font-size: 20px; color: #333;">$icon $title</h2>
        <p style="margin: 8px 0; color: #555; font-size: 14px; line-height: 1.5;"><strong style="color: #333;">• ${l10n.labelRoutine}:</strong> $routineName</p>
        <p style="margin: 8px 0; color: #555; font-size: 14px; line-height: 1.5;"><strong style="color: #333;">• ${l10n.labelTime}:</strong> $timestamp</p>
        $deviceSection
        $detailsSection
        $errorSection
      </td>
    </tr>
    <tr>
      <td style="padding: 16px 24px; text-align: center; font-size: 12px; color: #888; background-color: #f9f9f9; border-top: 1px solid #eee;">
        <p style="margin: 4px 0;">${l10n.emailFooterAutomatic}</p>
        <p style="margin: 4px 0;">${l10n.emailFooterManage}</p>
      </td>
    </tr>
  </table>
</body>
</html>
''';
  }

  /// Constrói o HTML do email de teste
  String _buildTestEmailHtml(NotificationLocalizations l10n) {
    final timestamp = l10n.formatDateTime(DateTime.now());
    final iconTag = _getIconImgTag();

    return '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin: 0; padding: 0; background-color: #f5f5f5; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;">
  <table width="100%" cellpadding="0" cellspacing="0" style="max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <tr>
      <td style="background-color: #1e3a5f; padding: 28px 24px; text-align: center;">
        <table width="100%" cellpadding="0" cellspacing="0">
          <tr>
            <td align="center">
              $iconTag
            </td>
          </tr>
          <tr>
            <td align="center" style="padding-top: 12px;">
              <span style="font-size: 32px; font-weight: 800; color: #FFFFFF; display: block;">ShadowSync</span>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td style="padding: 24px; border-left: 4px solid #4CAF50;">
        <h2 style="margin: 0 0 16px 0; font-size: 20px; color: #333;">🔔 ${l10n.emailTestTitle}</h2>
        <table width="100%" cellpadding="12" cellspacing="0" style="background-color: #e8f5e9; border-radius: 8px; margin: 16px 0;">
          <tr>
            <td>
              <p style="margin: 0; color: #2e7d32;">✅ <strong>${l10n.emailTestSuccess}</strong></p>
            </td>
          </tr>
        </table>
        <p style="margin: 8px 0; color: #555; font-size: 14px; line-height: 1.5;">${l10n.emailTestDescription}</p>
        <p style="margin: 8px 0; color: #555; font-size: 14px; line-height: 1.5;"><strong style="color: #333;">• ${l10n.labelDate}:</strong> $timestamp</p>
      </td>
    </tr>
    <tr>
      <td style="padding: 16px 24px; text-align: center; font-size: 12px; color: #888; background-color: #f9f9f9; border-top: 1px solid #eee;">
        <p style="margin: 4px 0;">${l10n.emailFooterAutomatic}</p>
      </td>
    </tr>
  </table>
</body>
</html>
''';
  }

  /// Libera recursos
  void dispose() {
    _configController.close();
  }
}
