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

  /// Frase "Backup concluído em {date}" / "Backup completed at {date}" para email/telegram
  String backupCompletedAt(String formattedDate) => _getString(
    'backupCompletedAt',
    pt: 'Backup concluído em $formattedDate',
    en: 'Backup completed at $formattedDate',
    fr: 'Sauvegarde terminée le $formattedDate',
    de: 'Sicherung abgeschlossen am $formattedDate',
    es: 'Respaldo completado el $formattedDate',
    it: 'Backup completato il $formattedDate',
    ja: '$formattedDate にバックアップ完了',
    zh: '备份完成于 $formattedDate',
    ko: '$formattedDate 에 백업 완료',
  );

  // ========== Notificações locais (Android / sistema) ==========

  String get notificationTitleBackupCompleted => _getString(
    'notificationTitleBackupCompleted',
    pt: 'Backup Concluído ✓',
    en: 'Backup Completed ✓',
    fr: 'Sauvegarde terminée ✓',
    de: 'Sicherung abgeschlossen ✓',
    es: 'Respaldo completado ✓',
    it: 'Backup completato ✓',
    ja: 'バックアップ完了 ✓',
    zh: '备份完成 ✓',
    ko: '백업 완료 ✓',
  );

  String get notificationTitleBackupFailed => _getString(
    'notificationTitleBackupFailed',
    pt: 'Falha no Backup ✗',
    en: 'Backup Failed ✗',
    fr: 'Échec de la sauvegarde ✗',
    de: 'Sicherung fehlgeschlagen ✗',
    es: 'Respaldo fallido ✗',
    it: 'Backup fallito ✗',
    ja: 'バックアップ失敗 ✗',
    zh: '备份失败 ✗',
    ko: '백업 실패 ✗',
  );

  String notificationBodyBackupSuccess(String routineName) => _getString(
    'notificationBodyBackupSuccess',
    pt: 'O backup "$routineName" foi concluído com sucesso.',
    en: 'The backup "$routineName" completed successfully.',
    fr: 'La sauvegarde "$routineName" s\'est terminée avec succès.',
    de: 'Die Sicherung "$routineName" wurde erfolgreich abgeschlossen.',
    es: 'El respaldo "$routineName" se completó correctamente.',
    it: 'Il backup "$routineName" è stato completato con successo.',
    ja: 'バックアップ「$routineName」が正常に完了しました。',
    zh: '备份「$routineName」已成功完成。',
    ko: '백업 "$routineName"이(가) 성공적으로 완료되었습니다.',
  );

  String notificationBodyBackupFailed(String routineName, String errorMessage) => _getString(
    'notificationBodyBackupFailed',
    pt: 'O backup "$routineName" falhou: $errorMessage',
    en: 'The backup "$routineName" failed: $errorMessage',
    fr: 'La sauvegarde "$routineName" a échoué : $errorMessage',
    de: 'Die Sicherung "$routineName" ist fehlgeschlagen: $errorMessage',
    es: 'El respaldo "$routineName" falló: $errorMessage',
    it: 'Il backup "$routineName" è fallito: $errorMessage',
    ja: 'バックアップ「$routineName」が失敗しました: $errorMessage',
    zh: '备份「$routineName」失败：$errorMessage',
    ko: '백업 "$routineName" 실패: $errorMessage',
  );

  String get notificationUnknownError => _getString(
    'notificationUnknownError',
    pt: 'Erro desconhecido',
    en: 'Unknown error',
    fr: 'Erreur inconnue',
    de: 'Unbekannter Fehler',
    es: 'Error desconocido',
    it: 'Errore sconosciuto',
    ja: '不明なエラー',
    zh: '未知错误',
    ko: '알 수 없는 오류',
  );

  String get notificationTitleNextBackup => _getString(
    'notificationTitleNextBackup',
    pt: 'Próximo Backup Agendado',
    en: 'Next Backup Scheduled',
    fr: 'Prochaine sauvegarde planifiée',
    de: 'Nächste Sicherung geplant',
    es: 'Próximo respaldo programado',
    it: 'Prossimo backup programmato',
    ja: '次のバックアップ予定',
    zh: '下次备份计划',
    ko: '다음 백업 예정',
  );

  String notificationBodyNextBackup(String routineName, String timeDescription) => _getString(
    'notificationBodyNextBackup',
    pt: '"$routineName" será executado $timeDescription.',
    en: '"$routineName" will run $timeDescription.',
    fr: '"$routineName" s\'exécutera $timeDescription.',
    de: '"$routineName" wird $timeDescription ausgeführt.',
    es: '"$routineName" se ejecutará $timeDescription.',
    it: '"$routineName" verrà eseguito $timeDescription.',
    ja: '「$routineName」は$timeDescription実行されます。',
    zh: '「$routineName」将在$timeDescription运行。',
    ko: '"$routineName"이(가) $timeDescription 실행됩니다.',
  );

  String get timeInLessThanMinute => _getString(
    'timeInLessThanMinute',
    pt: 'em menos de 1 minuto',
    en: 'in less than 1 minute',
    fr: 'dans moins d\'une minute',
    de: 'in weniger als einer Minute',
    es: 'en menos de 1 minuto',
    it: 'in meno di 1 minuto',
    ja: '1分以内に',
    zh: '不到1分钟',
    ko: '1분 이내에',
  );

  String timeMinutes(int n) => _getString(
    'timeMinutes',
    pt: n == 1 ? 'em 1 minuto' : 'em $n minutos',
    en: n == 1 ? 'in 1 minute' : 'in $n minutes',
    fr: n == 1 ? 'dans 1 minute' : 'dans $n minutes',
    de: n == 1 ? 'in 1 Minute' : 'in $n Minuten',
    es: n == 1 ? 'en 1 minuto' : 'en $n minutos',
    it: n == 1 ? 'in 1 minuto' : 'in $n minuti',
    ja: n == 1 ? '1分で' : '$n分で',
    zh: n == 1 ? '1分钟后' : '$n分钟后',
    ko: n == 1 ? '1분 후' : '$n분 후',
  );

  String timeHours(int n) => _getString(
    'timeHours',
    pt: n == 1 ? 'em 1 hora' : 'em $n horas',
    en: n == 1 ? 'in 1 hour' : 'in $n hours',
    fr: n == 1 ? 'dans 1 heure' : 'dans $n heures',
    de: n == 1 ? 'in 1 Stunde' : 'in $n Stunden',
    es: n == 1 ? 'en 1 hora' : 'en $n horas',
    it: n == 1 ? 'in 1 ora' : 'in $n ore',
    ja: n == 1 ? '1時間で' : '$n時間で',
    zh: n == 1 ? '1小时后' : '$n小时后',
    ko: n == 1 ? '1시간 후' : '$n시간 후',
  );

  String timeHoursAndMinutes(int hours, int minutes) => _getString(
    'timeHoursAndMinutes',
    pt: 'em ${hours}h${minutes}min',
    en: 'in ${hours}h${minutes}min',
    fr: 'dans ${hours}h${minutes}min',
    de: 'in ${hours}h ${minutes}min',
    es: 'en ${hours}h${minutes}min',
    it: 'in ${hours}h${minutes}min',
    ja: '$hours時間$minutes分で',
    zh: '$hours小时$minutes分钟后',
    ko: '$hours시간 $minutes분 후',
  );

  String timeDays(int n) => _getString(
    'timeDays',
    pt: n == 1 ? 'em 1 dia' : 'em $n dias',
    en: n == 1 ? 'in 1 day' : 'in $n days',
    fr: n == 1 ? 'dans 1 jour' : 'dans $n jours',
    de: n == 1 ? 'in 1 Tag' : 'in $n Tagen',
    es: n == 1 ? 'en 1 día' : 'en $n días',
    it: n == 1 ? 'in 1 giorno' : 'in $n giorni',
    ja: n == 1 ? '1日で' : '$n日で',
    zh: n == 1 ? '1天后' : '$n天后',
    ko: n == 1 ? '1일 후' : '$n일 후',
  );

  String get notificationTitleStatusActive => _getString(
    'notificationTitleStatusActive',
    pt: 'ShadowSync Ativo',
    en: 'ShadowSync Active',
    fr: 'ShadowSync actif',
    de: 'ShadowSync aktiv',
    es: 'ShadowSync activo',
    it: 'ShadowSync attivo',
    ja: 'ShadowSync 稼働中',
    zh: 'ShadowSync 运行中',
    ko: 'ShadowSync 활성',
  );

  String notificationBodyStatusActive(int count) => _getString(
    'notificationBodyStatusActive',
    pt: 'Você tem $count rotinas configuradas. Nenhum backup agendado no momento.',
    en: 'You have $count routine(s) configured. No backup scheduled at the moment.',
    fr: 'Vous avez $count routine(s) configurée(s). Aucune sauvegarde planifiée pour le moment.',
    de: 'Sie haben $count Routine(n) konfiguriert. Keine Sicherung geplant.',
    es: 'Tienes $count rutina(s) configurada(s). Ningún respaldo programado en este momento.',
    it: 'Hai $count routine configurate. Nessun backup programmato al momento.',
    ja: '$count件のルーチンが設定されています。現在予定されているバックアップはありません。',
    zh: '您已配置 $count 个例程。当前没有计划备份。',
    ko: '루틴 $count개가 구성되어 있습니다. 예정된 백업이 없습니다.',
  );

  /// Nome do canal de notificações (Android)
  String get notificationChannelName => _getString(
    'notificationChannelName',
    pt: 'ShadowSync Backups',
    en: 'ShadowSync Backups',
    fr: 'ShadowSync Sauvegardes',
    de: 'ShadowSync Sicherungen',
    es: 'ShadowSync Respaldos',
    it: 'ShadowSync Backup',
    ja: 'ShadowSync バックアップ',
    zh: 'ShadowSync 备份',
    ko: 'ShadowSync 백업',
  );

  /// Descrição do canal de notificações (Android)
  String get notificationChannelDescription => _getString(
    'notificationChannelDescription',
    pt: 'Notificações sobre status de backups e agendamentos',
    en: 'Notifications about backup status and scheduling',
    fr: 'Notifications sur l\'état des sauvegardes et la planification',
    de: 'Benachrichtigungen zu Sicherungsstatus und -planung',
    es: 'Notificaciones sobre estado de respaldos y programación',
    it: 'Notifiche su stato backup e pianificazione',
    ja: 'バックアップの状態とスケジュールの通知',
    zh: '有关备份状态和计划的通知',
    ko: '백업 상태 및 예약 알림',
  );

  /// Título da notificação do serviço em segundo plano (Android)
  String get backgroundServiceNotificationTitle => _getString(
    'backgroundServiceNotificationTitle',
    pt: 'ShadowSync',
    en: 'ShadowSync',
    fr: 'ShadowSync',
    de: 'ShadowSync',
    es: 'ShadowSync',
    it: 'ShadowSync',
    ja: 'ShadowSync',
    zh: 'ShadowSync',
    ko: 'ShadowSync',
  );

  /// Conteúdo da notificação do serviço em segundo plano (Android)
  String get backgroundServiceNotificationContent => _getString(
    'backgroundServiceNotificationContent',
    pt: 'Monitorando backups agendados',
    en: 'Monitoring scheduled backups',
    fr: 'Surveillance des sauvegardes planifiées',
    de: 'Überwacht geplante Sicherungen',
    es: 'Monitoreando respaldos programados',
    it: 'Monitoraggio backup programmati',
    ja: 'スケジュールされたバックアップを監視中',
    zh: '正在监控计划备份',
    ko: '예약된 백업 모니터링 중',
  );

  /// Nome do canal do serviço em segundo plano (Android)
  String get backgroundServiceChannelName => _getString(
    'backgroundServiceChannelName',
    pt: 'ShadowSync em segundo plano',
    en: 'ShadowSync Background Service',
    fr: 'ShadowSync en arrière-plan',
    de: 'ShadowSync im Hintergrund',
    es: 'ShadowSync en segundo plano',
    it: 'ShadowSync in background',
    ja: 'ShadowSync バックグラウンド',
    zh: 'ShadowSync 后台服务',
    ko: 'ShadowSync 백그라운드',
  );

  /// Descrição do canal do serviço em segundo plano (Android)
  String get backgroundServiceChannelDescription => _getString(
    'backgroundServiceChannelDescription',
    pt: 'Notificações do serviço de backup em segundo plano',
    en: 'Background backup service notifications',
    fr: 'Notifications du service de sauvegarde en arrière-plan',
    de: 'Benachrichtigungen des Hintergrund-Sicherungsdienstes',
    es: 'Notificaciones del servicio de respaldo en segundo plano',
    it: 'Notifiche del servizio di backup in background',
    ja: 'バックグラウンドバックアップサービスの通知',
    zh: '后台备份服务通知',
    ko: '백그라운드 백업 서비스 알림',
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
