import 'package:hive_flutter/hive_flutter.dart';

part 'email_notification_config.g.dart';

/// Configurações de notificação via Email SMTP.
@HiveType(typeId: 5)
class EmailNotificationConfig extends HiveObject {
  EmailNotificationConfig({
    this.isEnabled = false,
    this.smtpServer,
    this.smtpPort = 587,
    this.senderEmail,
    this.senderPassword,
    this.recipientEmails = const [],
    this.useSSL = false,
    this.useTLS = true,
    this.notifyOnSuccess = true,
    this.notifyOnFailure = true,
    this.notifyOnStart = false,
    this.presetName,
  });

  /// Se as notificações estão habilitadas
  @HiveField(0)
  bool isEnabled;

  /// Servidor SMTP (ex: smtp.gmail.com)
  @HiveField(1)
  String? smtpServer;

  /// Porta SMTP (padrão: 587 para TLS, 465 para SSL)
  @HiveField(2)
  int smtpPort;

  /// Email de origem (remetente)
  @HiveField(3)
  String? senderEmail;

  /// Senha ou App Password do email
  @HiveField(4)
  String? senderPassword;

  /// Lista de emails de destino
  @HiveField(5)
  List<String> recipientEmails;

  /// Usar conexão SSL (porta 465)
  @HiveField(6)
  bool useSSL;

  /// Usar STARTTLS (porta 587)
  @HiveField(7)
  bool useTLS;

  /// Notificar quando backup for concluído com sucesso
  @HiveField(8)
  bool notifyOnSuccess;

  /// Notificar quando backup falhar
  @HiveField(9)
  bool notifyOnFailure;

  /// Notificar quando backup iniciar
  @HiveField(10)
  bool notifyOnStart;

  /// Nome do preset usado (gmail, outlook, yahoo, icloud, custom)
  @HiveField(11)
  String? presetName;

  /// Verifica se a configuração está completa para enviar notificações
  bool get isConfigured =>
      isEnabled &&
      smtpServer != null &&
      smtpServer!.isNotEmpty &&
      senderEmail != null &&
      senderEmail!.isNotEmpty &&
      senderPassword != null &&
      senderPassword!.isNotEmpty &&
      recipientEmails.isNotEmpty;

  /// Cria uma cópia com os campos atualizados
  EmailNotificationConfig copyWith({
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
  }) {
    return EmailNotificationConfig(
      isEnabled: isEnabled ?? this.isEnabled,
      smtpServer: smtpServer ?? this.smtpServer,
      smtpPort: smtpPort ?? this.smtpPort,
      senderEmail: senderEmail ?? this.senderEmail,
      senderPassword: senderPassword ?? this.senderPassword,
      recipientEmails: recipientEmails ?? List<String>.from(this.recipientEmails),
      useSSL: useSSL ?? this.useSSL,
      useTLS: useTLS ?? this.useTLS,
      notifyOnSuccess: notifyOnSuccess ?? this.notifyOnSuccess,
      notifyOnFailure: notifyOnFailure ?? this.notifyOnFailure,
      notifyOnStart: notifyOnStart ?? this.notifyOnStart,
      presetName: presetName ?? this.presetName,
    );
  }
}
