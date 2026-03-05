import 'package:flutter/material.dart';

import 'locale_service.dart';

/// Classe para fornecer strings localizadas para os serviços de notificação.
/// 
/// Esta classe permite que serviços de backend (Telegram, Email) acessem
/// traduções sem precisar de BuildContext.
class NotificationLocalizations {
  NotificationLocalizations._();
  
  static NotificationLocalizations? _instance;
  
  /// Obtém a instância singleton
  static NotificationLocalizations getInstance() {
    _instance ??= NotificationLocalizations._();
    return _instance!;
  }
  
  /// Obtém o locale atual do LocaleService
  Locale get _currentLocale => LocaleService.getInstance().currentLocale;
  
  /// Obtém o código do idioma atual
  String get _languageCode {
    final locale = _currentLocale;
    // Normaliza para códigos base (ex: pt_BR -> pt, zh_CN -> zh)
    if (locale.languageCode == 'pt') return 'pt';
    if (locale.languageCode == 'zh') return 'zh';
    return locale.languageCode;
  }
  
  // ========== Títulos de Mensagens ==========
  
  String get telegramTestTitle => _getString(
    'telegramTestTitle',
    pt: 'ShadowSync - Teste de Configuração',
    en: 'ShadowSync - Configuration Test',
    fr: 'ShadowSync - Test de Configuration',
    de: 'ShadowSync - Konfigurationstest',
    es: 'ShadowSync - Prueba de Configuración',
    it: 'ShadowSync - Test di Configurazione',
    ja: 'ShadowSync - 設定テスト',
    zh: 'ShadowSync - 配置测试',
    ko: 'ShadowSync - 구성 테스트',
  );
  
  String get telegramTestSuccess => _getString(
    'telegramTestSuccess',
    pt: 'Sua configuração de notificação está funcionando!',
    en: 'Your notification configuration is working!',
    fr: 'Votre configuration de notification fonctionne !',
    de: 'Ihre Benachrichtigungskonfiguration funktioniert!',
    es: '¡Tu configuración de notificación está funcionando!',
    it: 'La tua configurazione di notifica funziona!',
    ja: '通知設定が正常に動作しています！',
    zh: '您的通知配置工作正常！',
    ko: '알림 구성이 정상적으로 작동합니다!',
  );
  
  String get backupStartedTitle => _getString(
    'backupStartedTitle',
    pt: 'ShadowSync - Backup Iniciado',
    en: 'ShadowSync - Backup Started',
    fr: 'ShadowSync - Sauvegarde Démarrée',
    de: 'ShadowSync - Sicherung Gestartet',
    es: 'ShadowSync - Respaldo Iniciado',
    it: 'ShadowSync - Backup Avviato',
    ja: 'ShadowSync - バックアップ開始',
    zh: 'ShadowSync - 备份已开始',
    ko: 'ShadowSync - 백업 시작됨',
  );
  
  String get backupCompletedTitle => _getString(
    'backupCompletedTitle',
    pt: 'ShadowSync - Backup Concluído',
    en: 'ShadowSync - Backup Completed',
    fr: 'ShadowSync - Sauvegarde Terminée',
    de: 'ShadowSync - Sicherung Abgeschlossen',
    es: 'ShadowSync - Respaldo Completado',
    it: 'ShadowSync - Backup Completato',
    ja: 'ShadowSync - バックアップ完了',
    zh: 'ShadowSync - 备份已完成',
    ko: 'ShadowSync - 백업 완료',
  );
  
  String get backupFailedTitle => _getString(
    'backupFailedTitle',
    pt: 'ShadowSync - Backup Falhou',
    en: 'ShadowSync - Backup Failed',
    fr: 'ShadowSync - Sauvegarde Échouée',
    de: 'ShadowSync - Sicherung Fehlgeschlagen',
    es: 'ShadowSync - Respaldo Fallido',
    it: 'ShadowSync - Backup Fallito',
    ja: 'ShadowSync - バックアップ失敗',
    zh: 'ShadowSync - 备份失败',
    ko: 'ShadowSync - 백업 실패',
  );
  
  // ========== Labels (Rótulos) ==========
  
  String get labelRoutine => _getString(
    'labelRoutine',
    pt: 'Rotina',
    en: 'Routine',
    fr: 'Routine',
    de: 'Routine',
    es: 'Rutina',
    it: 'Routine',
    ja: 'ルーティン',
    zh: '例程',
    ko: '루틴',
  );
  
  String get labelDevice => _getString(
    'labelDevice',
    pt: 'Dispositivo',
    en: 'Device',
    fr: 'Appareil',
    de: 'Gerät',
    es: 'Dispositivo',
    it: 'Dispositivo',
    ja: 'デバイス',
    zh: '设备',
    ko: '기기',
  );
  
  String get labelStartTime => _getString(
    'labelStartTime',
    pt: 'Início',
    en: 'Start',
    fr: 'Début',
    de: 'Start',
    es: 'Inicio',
    it: 'Inizio',
    ja: '開始',
    zh: '开始',
    ko: '시작',
  );
  
  String get labelEndTime => _getString(
    'labelEndTime',
    pt: 'Conclusão',
    en: 'Completion',
    fr: 'Fin',
    de: 'Abschluss',
    es: 'Finalización',
    it: 'Completamento',
    ja: '完了',
    zh: '完成',
    ko: '완료',
  );
  
  String get labelTime => _getString(
    'labelTime',
    pt: 'Horário',
    en: 'Time',
    fr: 'Heure',
    de: 'Zeit',
    es: 'Hora',
    it: 'Orario',
    ja: '時間',
    zh: '时间',
    ko: '시간',
  );
  
  String get labelDetails => _getString(
    'labelDetails',
    pt: 'Detalhes',
    en: 'Details',
    fr: 'Détails',
    de: 'Details',
    es: 'Detalles',
    it: 'Dettagli',
    ja: '詳細',
    zh: '详情',
    ko: '상세',
  );
  
  String get labelError => _getString(
    'labelError',
    pt: 'Erro',
    en: 'Error',
    fr: 'Erreur',
    de: 'Fehler',
    es: 'Error',
    it: 'Errore',
    ja: 'エラー',
    zh: '错误',
    ko: '오류',
  );
  
  String get labelDate => _getString(
    'labelDate',
    pt: 'Data',
    en: 'Date',
    fr: 'Date',
    de: 'Datum',
    es: 'Fecha',
    it: 'Data',
    ja: '日付',
    zh: '日期',
    ko: '날짜',
  );
  
  // ========== Email Específico ==========
  
  String get emailSubjectBackupStarted => _getString(
    'emailSubjectBackupStarted',
    pt: '🔄 ShadowSync - Backup Iniciado',
    en: '🔄 ShadowSync - Backup Started',
    fr: '🔄 ShadowSync - Sauvegarde Démarrée',
    de: '🔄 ShadowSync - Sicherung Gestartet',
    es: '🔄 ShadowSync - Respaldo Iniciado',
    it: '🔄 ShadowSync - Backup Avviato',
    ja: '🔄 ShadowSync - バックアップ開始',
    zh: '🔄 ShadowSync - 备份已开始',
    ko: '🔄 ShadowSync - 백업 시작됨',
  );
  
  String get emailSubjectBackupCompleted => _getString(
    'emailSubjectBackupCompleted',
    pt: '✅ ShadowSync - Backup Concluído',
    en: '✅ ShadowSync - Backup Completed',
    fr: '✅ ShadowSync - Sauvegarde Terminée',
    de: '✅ ShadowSync - Sicherung Abgeschlossen',
    es: '✅ ShadowSync - Respaldo Completado',
    it: '✅ ShadowSync - Backup Completato',
    ja: '✅ ShadowSync - バックアップ完了',
    zh: '✅ ShadowSync - 备份已完成',
    ko: '✅ ShadowSync - 백업 완료',
  );
  
  String get emailSubjectBackupFailed => _getString(
    'emailSubjectBackupFailed',
    pt: '❌ ShadowSync - Backup Falhou',
    en: '❌ ShadowSync - Backup Failed',
    fr: '❌ ShadowSync - Sauvegarde Échouée',
    de: '❌ ShadowSync - Sicherung Fehlgeschlagen',
    es: '❌ ShadowSync - Respaldo Fallido',
    it: '❌ ShadowSync - Backup Fallito',
    ja: '❌ ShadowSync - バックアップ失敗',
    zh: '❌ ShadowSync - 备份失败',
    ko: '❌ ShadowSync - 백업 실패',
  );
  
  String get emailSubjectTest => _getString(
    'emailSubjectTest',
    pt: '🔔 ShadowSync - Teste de Configuração',
    en: '🔔 ShadowSync - Configuration Test',
    fr: '🔔 ShadowSync - Test de Configuration',
    de: '🔔 ShadowSync - Konfigurationstest',
    es: '🔔 ShadowSync - Prueba de Configuración',
    it: '🔔 ShadowSync - Test di Configurazione',
    ja: '🔔 ShadowSync - 設定テスト',
    zh: '🔔 ShadowSync - 配置测试',
    ko: '🔔 ShadowSync - 구성 테스트',
  );
  
  String get emailTestTitle => _getString(
    'emailTestTitle',
    pt: 'Teste de Configuração',
    en: 'Configuration Test',
    fr: 'Test de Configuration',
    de: 'Konfigurationstest',
    es: 'Prueba de Configuración',
    it: 'Test di Configurazione',
    ja: '設定テスト',
    zh: '配置测试',
    ko: '구성 테스트',
  );
  
  String get emailTestSuccess => _getString(
    'emailTestSuccess',
    pt: 'Sua configuração de email está funcionando!',
    en: 'Your email configuration is working!',
    fr: 'Votre configuration email fonctionne !',
    de: 'Ihre E-Mail-Konfiguration funktioniert!',
    es: '¡Tu configuración de email está funcionando!',
    it: 'La tua configurazione email funziona!',
    ja: 'メール設定が正常に動作しています！',
    zh: '您的邮件配置工作正常！',
    ko: '이메일 구성이 정상적으로 작동합니다!',
  );
  
  String get emailTestDescription => _getString(
    'emailTestDescription',
    pt: 'Este é um email de teste para verificar que as notificações por email estão configuradas corretamente.',
    en: 'This is a test email to verify that email notifications are configured correctly.',
    fr: 'Ceci est un email de test pour vérifier que les notifications par email sont correctement configurées.',
    de: 'Dies ist eine Test-E-Mail, um zu überprüfen, ob die E-Mail-Benachrichtigungen korrekt konfiguriert sind.',
    es: 'Este es un email de prueba para verificar que las notificaciones por email están configuradas correctamente.',
    it: 'Questa è un\'email di test per verificare che le notifiche email siano configurate correttamente.',
    ja: 'これはメール通知が正しく設定されていることを確認するためのテストメールです。',
    zh: '这是一封测试邮件，用于验证邮件通知是否配置正确。',
    ko: '이것은 이메일 알림이 올바르게 구성되어 있는지 확인하기 위한 테스트 이메일입니다.',
  );
  
  String get emailFooterAutomatic => _getString(
    'emailFooterAutomatic',
    pt: 'Esta é uma notificação automática do ShadowSync.',
    en: 'This is an automatic notification from ShadowSync.',
    fr: 'Ceci est une notification automatique de ShadowSync.',
    de: 'Dies ist eine automatische Benachrichtigung von ShadowSync.',
    es: 'Esta es una notificación automática de ShadowSync.',
    it: 'Questa è una notifica automatica da ShadowSync.',
    ja: 'これはShadowSyncからの自動通知です。',
    zh: '这是来自ShadowSync的自动通知。',
    ko: '이것은 ShadowSync의 자동 알림입니다.',
  );
  
  String get emailFooterManage => _getString(
    'emailFooterManage',
    pt: 'Gerencie suas notificações nas configurações do aplicativo.',
    en: 'Manage your notifications in the app settings.',
    fr: 'Gérez vos notifications dans les paramètres de l\'application.',
    de: 'Verwalten Sie Ihre Benachrichtigungen in den App-Einstellungen.',
    es: 'Gestiona tus notificaciones en la configuración de la aplicación.',
    it: 'Gestisci le tue notifiche nelle impostazioni dell\'app.',
    ja: 'アプリ設定で通知を管理してください。',
    zh: '在应用设置中管理您的通知。',
    ko: '앱 설정에서 알림을 관리하세요.',
  );
  
  String get backupStarted => _getString(
    'backupStarted',
    pt: 'Backup Iniciado',
    en: 'Backup Started',
    fr: 'Sauvegarde Démarrée',
    de: 'Sicherung Gestartet',
    es: 'Respaldo Iniciado',
    it: 'Backup Avviato',
    ja: 'バックアップ開始',
    zh: '备份已开始',
    ko: '백업 시작됨',
  );
  
  String get backupCompleted => _getString(
    'backupCompleted',
    pt: 'Backup Concluído',
    en: 'Backup Completed',
    fr: 'Sauvegarde Terminée',
    de: 'Sicherung Abgeschlossen',
    es: 'Respaldo Completado',
    it: 'Backup Completato',
    ja: 'バックアップ完了',
    zh: '备份已完成',
    ko: '백업 완료',
  );

  String get backupFailed => _getString(
    'backupFailed',
    pt: 'Backup Falhou',
    en: 'Backup Failed',
    fr: 'Sauvegarde Échouée',
    de: 'Sicherung Fehlgeschlagen',
    es: 'Respaldo Fallido',
    it: 'Backup Fallito',
    ja: 'バックアップ失敗',
    zh: '备份失败',
    ko: '백업 실패',
  );
  
  // ========== Formatação de Data/Hora ==========
  
  /// Retorna "at" ou equivalente no idioma atual (ex: "às" em português)
  String get dateTimeConnector => _getString(
    'dateTimeConnector',
    pt: 'às',
    en: 'at',
    fr: 'à',
    de: 'um',
    es: 'a las',
    it: 'alle',
    ja: '',  // Japonês não usa conector
    zh: '',  // Chinês não usa conector
    ko: '',  // Coreano não usa conector
  );
  
  /// Formata DateTime para exibição considerando o locale
  String formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    
    final connector = dateTimeConnector;
    
    // Idiomas asiáticos não usam conector
    if (connector.isEmpty) {
      return '$day/$month/$year $hour:$minute';
    }
    
    return '$day/$month/$year $connector $hour:$minute';
  }
  
  // ========== Mensagens de Status ==========
  
  String get configurationIncomplete => _getString(
    'configurationIncomplete',
    pt: 'Configuração incompleta',
    en: 'Configuration incomplete',
    fr: 'Configuration incomplète',
    de: 'Konfiguration unvollständig',
    es: 'Configuración incompleta',
    it: 'Configurazione incompleta',
    ja: '設定が不完全です',
    zh: '配置不完整',
    ko: '구성이 완료되지 않음',
  );
  
  String get notificationIgnored => _getString(
    'notificationIgnored',
    pt: 'Notificação ignorada (desabilitada para este evento)',
    en: 'Notification ignored (disabled for this event)',
    fr: 'Notification ignorée (désactivée pour cet événement)',
    de: 'Benachrichtigung ignoriert (für dieses Ereignis deaktiviert)',
    es: 'Notificación ignorada (deshabilitada para este evento)',
    it: 'Notifica ignorata (disabilitata per questo evento)',
    ja: '通知が無視されました（このイベントでは無効）',
    zh: '通知已忽略（此事件已禁用）',
    ko: '알림 무시됨 (이 이벤트에 대해 비활성화됨)',
  );
  
  String get messageSentSuccess => _getString(
    'messageSentSuccess',
    pt: 'Mensagem enviada com sucesso',
    en: 'Message sent successfully',
    fr: 'Message envoyé avec succès',
    de: 'Nachricht erfolgreich gesendet',
    es: 'Mensaje enviado con éxito',
    it: 'Messaggio inviato con successo',
    ja: 'メッセージが正常に送信されました',
    zh: '消息发送成功',
    ko: '메시지가 성공적으로 전송되었습니다',
  );
  
  String get emailSentSuccess => _getString(
    'emailSentSuccess',
    pt: 'Email enviado com sucesso',
    en: 'Email sent successfully',
    fr: 'Email envoyé avec succès',
    de: 'E-Mail erfolgreich gesendet',
    es: 'Email enviado con éxito',
    it: 'Email inviata con successo',
    ja: 'メールが正常に送信されました',
    zh: '邮件发送成功',
    ko: '이메일이 성공적으로 전송되었습니다',
  );
  
  String get invalidBotTokenOrChatId => _getString(
    'invalidBotTokenOrChatId',
    pt: 'Bot Token ou Chat ID inválido',
    en: 'Invalid Bot Token or Chat ID',
    fr: 'Token Bot ou ID Chat invalide',
    de: 'Ungültiger Bot-Token oder Chat-ID',
    es: 'Token de Bot o Chat ID inválido',
    it: 'Token Bot o Chat ID non valido',
    ja: 'ボットトークンまたはチャットIDが無効です',
    zh: 'Bot令牌或聊天ID无效',
    ko: '봇 토큰 또는 채팅 ID가 유효하지 않습니다',
  );
  
  String get connectionTimeout => _getString(
    'connectionTimeout',
    pt: 'Tempo limite de conexão',
    en: 'Connection timeout',
    fr: 'Délai de connexion dépassé',
    de: 'Verbindungs-Timeout',
    es: 'Tiempo de conexión agotado',
    it: 'Timeout connessione',
    ja: '接続タイムアウト',
    zh: '连接超时',
    ko: '연결 시간 초과',
  );
  
  String connectionError(String message) => _getString(
    'connectionError',
    pt: 'Erro de conexão: $message',
    en: 'Connection error: $message',
    fr: 'Erreur de connexion : $message',
    de: 'Verbindungsfehler: $message',
    es: 'Error de conexión: $message',
    it: 'Errore di connessione: $message',
    ja: '接続エラー: $message',
    zh: '连接错误: $message',
    ko: '연결 오류: $message',
  );
  
  String unexpectedError(String error) => _getString(
    'unexpectedError',
    pt: 'Erro inesperado: $error',
    en: 'Unexpected error: $error',
    fr: 'Erreur inattendue : $error',
    de: 'Unerwarteter Fehler: $error',
    es: 'Error inesperado: $error',
    it: 'Errore imprevisto: $error',
    ja: '予期しないエラー: $error',
    zh: '意外错误: $error',
    ko: '예기치 않은 오류: $error',
  );
  
  String errorWithDescription(String description) => _getString(
    'errorWithDescription',
    pt: 'Erro: $description',
    en: 'Error: $description',
    fr: 'Erreur : $description',
    de: 'Fehler: $description',
    es: 'Error: $description',
    it: 'Errore: $description',
    ja: 'エラー: $description',
    zh: '错误: $description',
    ko: '오류: $description',
  );
  
  String httpError(int statusCode) => _getString(
    'httpError',
    pt: 'Erro HTTP $statusCode',
    en: 'HTTP Error $statusCode',
    fr: 'Erreur HTTP $statusCode',
    de: 'HTTP-Fehler $statusCode',
    es: 'Error HTTP $statusCode',
    it: 'Errore HTTP $statusCode',
    ja: 'HTTPエラー $statusCode',
    zh: 'HTTP错误 $statusCode',
    ko: 'HTTP 오류 $statusCode',
  );

  // ========== Email Error Messages ==========
  
  String get emailAuthenticationFailed => _getString(
    'emailAuthenticationFailed',
    pt: 'Falha de autenticação. Verifique email e senha (use App Password se tiver 2FA)',
    en: 'Authentication failed. Check email and password (use App Password if you have 2FA)',
    fr: 'Échec d\'authentification. Vérifiez l\'email et le mot de passe (utilisez un mot de passe d\'application si vous avez la 2FA)',
    de: 'Authentifizierung fehlgeschlagen. Überprüfen Sie E-Mail und Passwort (verwenden Sie App-Passwort bei 2FA)',
    es: 'Fallo de autenticación. Verifique email y contraseña (use App Password si tiene 2FA)',
    it: 'Autenticazione fallita. Verifica email e password (usa App Password se hai la 2FA)',
    ja: '認証に失敗しました。メールとパスワードを確認してください（2FAの場合はアプリパスワードを使用）',
    zh: '认证失败。请检查邮箱和密码（如果有双重认证请使用应用密码）',
    ko: '인증 실패. 이메일과 비밀번호를 확인하세요 (2FA가 있는 경우 앱 비밀번호 사용)',
  );
  
  String get emailConnectionFailed => _getString(
    'emailConnectionFailed',
    pt: 'Não foi possível conectar ao servidor SMTP. Verifique o servidor e a porta',
    en: 'Could not connect to SMTP server. Check server and port',
    fr: 'Impossible de se connecter au serveur SMTP. Vérifiez le serveur et le port',
    de: 'Verbindung zum SMTP-Server nicht möglich. Überprüfen Sie Server und Port',
    es: 'No se pudo conectar al servidor SMTP. Verifique el servidor y el puerto',
    it: 'Impossibile connettersi al server SMTP. Verifica server e porta',
    ja: 'SMTPサーバーに接続できません。サーバーとポートを確認してください',
    zh: '无法连接到SMTP服务器。请检查服务器和端口',
    ko: 'SMTP 서버에 연결할 수 없습니다. 서버와 포트를 확인하세요',
  );
  
  String get emailTimeoutError => _getString(
    'emailTimeoutError',
    pt: 'Tempo limite excedido. O servidor demorou muito para responder',
    en: 'Timeout exceeded. Server took too long to respond',
    fr: 'Délai dépassé. Le serveur a mis trop de temps à répondre',
    de: 'Zeitüberschreitung. Der Server hat zu lange gebraucht, um zu antworten',
    es: 'Tiempo de espera excedido. El servidor tardó demasiado en responder',
    it: 'Timeout superato. Il server ha impiegato troppo tempo a rispondere',
    ja: 'タイムアウト。サーバーの応答に時間がかかりすぎました',
    zh: '超时。服务器响应时间过长',
    ko: '시간 초과. 서버 응답 시간이 너무 깁니다',
  );
  
  String get emailCertificateError => _getString(
    'emailCertificateError',
    pt: 'Erro de certificado SSL/TLS. Verifique as configurações de segurança',
    en: 'SSL/TLS certificate error. Check security settings',
    fr: 'Erreur de certificat SSL/TLS. Vérifiez les paramètres de sécurité',
    de: 'SSL/TLS-Zertifikatfehler. Überprüfen Sie die Sicherheitseinstellungen',
    es: 'Error de certificado SSL/TLS. Verifique la configuración de seguridad',
    it: 'Errore certificato SSL/TLS. Verifica le impostazioni di sicurezza',
    ja: 'SSL/TLS証明書エラー。セキュリティ設定を確認してください',
    zh: 'SSL/TLS证书错误。请检查安全设置',
    ko: 'SSL/TLS 인증서 오류. 보안 설정을 확인하세요',
  );
  
  String get emailGenericError => _getString(
    'emailGenericError',
    pt: 'Erro ao enviar email',
    en: 'Error sending email',
    fr: 'Erreur lors de l\'envoi de l\'email',
    de: 'Fehler beim Senden der E-Mail',
    es: 'Error al enviar el email',
    it: 'Errore nell\'invio dell\'email',
    ja: 'メール送信エラー',
    zh: '发送邮件错误',
    ko: '이메일 전송 오류',
  );
  
  // ========== Método auxiliar ==========
  
  /// Retorna a string traduzida baseada no idioma atual
  String _getString(
    String key, {
    required String pt,
    required String en,
    required String fr,
    required String de,
    required String es,
    required String it,
    required String ja,
    required String zh,
    required String ko,
  }) {
    return switch (_languageCode) {
      'pt' => pt,
      'en' => en,
      'fr' => fr,
      'de' => de,
      'es' => es,
      'it' => it,
      'ja' => ja,
      'zh' => zh,
      'ko' => ko,
      _ => en, // Fallback para inglês
    };
  }
}
