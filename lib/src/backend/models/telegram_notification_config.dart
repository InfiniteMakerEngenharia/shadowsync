import 'package:hive_flutter/hive_flutter.dart';

part 'telegram_notification_config.g.dart';

/// Configurações de notificação via Telegram Bot API.
@HiveType(typeId: 4)
class TelegramNotificationConfig extends HiveObject {
  TelegramNotificationConfig({
    this.isEnabled = false,
    this.botToken,
    this.chatId,
    this.notifyOnSuccess = true,
    this.notifyOnFailure = true,
    this.notifyOnStart = false,
  });

  /// Se as notificações estão habilitadas
  @HiveField(0)
  bool isEnabled;

  /// Token do bot Telegram (obtido do BotFather)
  @HiveField(1)
  String? botToken;

  /// Chat ID do usuário ou grupo para enviar mensagens
  @HiveField(2)
  String? chatId;

  /// Notificar quando backup for concluído com sucesso
  @HiveField(3)
  bool notifyOnSuccess;

  /// Notificar quando backup falhar
  @HiveField(4)
  bool notifyOnFailure;

  /// Notificar quando backup iniciar
  @HiveField(5)
  bool notifyOnStart;

  /// Verifica se a configuração está completa para enviar notificações
  bool get isConfigured =>
      isEnabled &&
      botToken != null &&
      botToken!.isNotEmpty &&
      chatId != null &&
      chatId!.isNotEmpty;

  /// Cria uma cópia com os campos atualizados
  TelegramNotificationConfig copyWith({
    bool? isEnabled,
    String? botToken,
    String? chatId,
    bool? notifyOnSuccess,
    bool? notifyOnFailure,
    bool? notifyOnStart,
  }) {
    return TelegramNotificationConfig(
      isEnabled: isEnabled ?? this.isEnabled,
      botToken: botToken ?? this.botToken,
      chatId: chatId ?? this.chatId,
      notifyOnSuccess: notifyOnSuccess ?? this.notifyOnSuccess,
      notifyOnFailure: notifyOnFailure ?? this.notifyOnFailure,
      notifyOnStart: notifyOnStart ?? this.notifyOnStart,
    );
  }

  /// Mascara o token do bot para exibição segura
  String get maskedBotToken {
    if (botToken == null || botToken!.isEmpty) return '';
    if (botToken!.length <= 10) return '***';
    return '${botToken!.substring(0, 5)}...${botToken!.substring(botToken!.length - 5)}';
  }
}
