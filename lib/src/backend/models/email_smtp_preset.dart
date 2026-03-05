/// Preset de configuração SMTP para provedores populares.
class EmailSmtpPreset {
  const EmailSmtpPreset({
    required this.name,
    required this.displayName,
    required this.smtpServer,
    required this.port,
    required this.useSSL,
    required this.useTLS,
  });

  /// Identificador único do preset
  final String name;

  /// Nome de exibição na UI
  final String displayName;

  /// Servidor SMTP
  final String smtpServer;

  /// Porta SMTP
  final int port;

  /// Usar SSL (porta 465)
  final bool useSSL;

  /// Usar STARTTLS (porta 587)
  final bool useTLS;

  /// Lista de presets disponíveis
  static const List<EmailSmtpPreset> presets = [
    EmailSmtpPreset(
      name: 'gmail',
      displayName: 'Gmail',
      smtpServer: 'smtp.gmail.com',
      port: 587,
      useSSL: false,
      useTLS: true,
    ),
    EmailSmtpPreset(
      name: 'outlook',
      displayName: 'Outlook / Hotmail',
      smtpServer: 'smtp.office365.com',
      port: 587,
      useSSL: false,
      useTLS: true,
    ),
    EmailSmtpPreset(
      name: 'yahoo',
      displayName: 'Yahoo Mail',
      smtpServer: 'smtp.mail.yahoo.com',
      port: 587,
      useSSL: false,
      useTLS: true,
    ),
    EmailSmtpPreset(
      name: 'icloud',
      displayName: 'iCloud Mail',
      smtpServer: 'smtp.mail.me.com',
      port: 587,
      useSSL: false,
      useTLS: true,
    ),
    EmailSmtpPreset(
      name: 'zoho',
      displayName: 'Zoho Mail',
      smtpServer: 'smtp.zoho.com',
      port: 587,
      useSSL: false,
      useTLS: true,
    ),
    EmailSmtpPreset(
      name: 'custom',
      displayName: 'Personalizado',
      smtpServer: '',
      port: 587,
      useSSL: false,
      useTLS: true,
    ),
  ];

  /// Obtém um preset pelo nome
  static EmailSmtpPreset? getByName(String? name) {
    if (name == null) return null;
    try {
      return presets.firstWhere((p) => p.name == name);
    } catch (_) {
      return null;
    }
  }
}
