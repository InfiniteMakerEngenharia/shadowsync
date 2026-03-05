import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/backup_routine.dart';

// ============================================================================
// CONFIGURAÇÃO DO SERVIÇO DE NOTIFICAÇÕES
// ============================================================================

/// ID do canal de notificações para backups
const String kNotificationChannelId = 'shadowsync_backup_channel';

/// Nome do canal de notificações
const String kNotificationChannelName = 'ShadowSync Backups';

/// Descrição do canal de notificações
const String kNotificationChannelDescription =
    'Notificações sobre status de backups e agendamentos';

/// ID da notificação de backup concluído
const int kBackupCompletedNotificationId = 1;

/// ID da notificação de próximo backup
const int kNextBackupNotificationId = 2;

/// Intervalo em minutos para notificações periódicas (1 hora)
const int kPeriodicNotificationIntervalMinutes = 60;

// ============================================================================
// SERVIÇO DE NOTIFICAÇÕES
// ============================================================================

/// Serviço responsável por gerenciar notificações do aplicativo.
/// 
/// Envia notificações quando:
/// - Um backup é concluído (sucesso ou falha)
/// - Periodicamente informando sobre o próximo backup agendado
class NotificationService {
  NotificationService._();

  static NotificationService? _instance;
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Timer? _periodicTimer;
  List<BackupRoutine> _routines = [];

  /// Obtém a instância singleton do serviço
  static Future<NotificationService> getInstance() async {
    if (_instance == null) {
      _instance = NotificationService._();
      await _instance!._initialize();
    }
    return _instance!;
  }

  /// Inicializa o plugin de notificações
  Future<void> _initialize() async {
    // Configurações para Android
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configurações para iOS
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Configurações para Linux
    const linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Abrir ShadowSync',
    );

    // Configurações para macOS
    const macOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      linux: linuxSettings,
      macOS: macOSSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    debugPrint('[NotificationService] Plugin inicializado');

    // Cria canal de notificação no Android
    if (Platform.isAndroid) {
      await _createNotificationChannel();
    }

    // Solicita permissão no Android 13+
    if (Platform.isAndroid) {
      await _requestAndroidPermission();
    }

    // Solicita permissão no macOS
    if (Platform.isMacOS) {
      await _requestMacOSPermission();
    }
  }

  /// Solicita permissão de notificação no macOS
  Future<void> _requestMacOSPermission() async {
    final macOSPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>();

    if (macOSPlugin != null) {
      final granted = await macOSPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('[NotificationService] Permissão macOS concedida: $granted');
    }
  }

  /// Cria o canal de notificação no Android
  Future<void> _createNotificationChannel() async {
    const androidChannel = AndroidNotificationChannel(
      kNotificationChannelId,
      kNotificationChannelName,
      description: kNotificationChannelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  /// Solicita permissão de notificação no Android 13+
  Future<void> _requestAndroidPermission() async {
    final androidPlugin = _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }
  }

  /// Callback quando o usuário toca em uma notificação
  void _onNotificationTapped(NotificationResponse response) {
    // Por enquanto, apenas loga a ação
    debugPrint('Notificação tocada: ${response.payload}');
  }

  /// Notifica que um backup foi concluído
  Future<void> notifyBackupCompleted({
    required String routineName,
    required bool success,
    String? errorMessage,
  }) async {
    final title = success ? 'Backup Concluído ✓' : 'Falha no Backup ✗';
    final body = success
        ? 'O backup "$routineName" foi concluído com sucesso.'
        : 'O backup "$routineName" falhou: ${errorMessage ?? "Erro desconhecido"}';

    await _showNotification(
      id: kBackupCompletedNotificationId,
      title: title,
      body: body,
      payload: 'backup_completed:$routineName',
    );
  }

  /// Notifica sobre o próximo backup agendado
  Future<void> notifyNextBackup({
    required String routineName,
    required DateTime nextRunAt,
  }) async {
    final now = DateTime.now();
    final difference = nextRunAt.difference(now);

    String timeDescription;
    if (difference.inMinutes < 1) {
      timeDescription = 'em menos de 1 minuto';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      timeDescription = 'em $minutes ${minutes == 1 ? 'minuto' : 'minutos'}';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      final remainingMinutes = difference.inMinutes % 60;
      if (remainingMinutes > 0) {
        timeDescription = 'em ${hours}h${remainingMinutes}min';
      } else {
        timeDescription = 'em $hours ${hours == 1 ? 'hora' : 'horas'}';
      }
    } else {
      final days = difference.inDays;
      timeDescription = 'em $days ${days == 1 ? 'dia' : 'dias'}';
    }

    await _showNotification(
      id: kNextBackupNotificationId,
      title: 'Próximo Backup Agendado',
      body: '"$routineName" será executado $timeDescription.',
      payload: 'next_backup:$routineName',
    );
  }

  /// Exibe uma notificação
  Future<void> _showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    debugPrint('[NotificationService] Exibindo notificação: $title - $body');
    
    const androidDetails = AndroidNotificationDetails(
      kNotificationChannelId,
      kNotificationChannelName,
      channelDescription: kNotificationChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const linuxDetails = LinuxNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
      linux: linuxDetails,
    );

    try {
      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
      debugPrint('[NotificationService] Notificação enviada com sucesso');
    } catch (e) {
      debugPrint('[NotificationService] Erro ao enviar notificação: $e');
    }
  }

  /// Inicia o timer de notificações periódicas
  void startPeriodicNotifications(List<BackupRoutine> routines) {
    _routines = routines;
    _periodicTimer?.cancel();

    debugPrint('[NotificationService] Iniciando notificações periódicas com ${routines.length} rotinas');

    // Executa imediatamente a primeira vez
    _checkAndNotifyNextBackup();

    // Configura timer para executar a cada minuto (para testes)
    _periodicTimer = Timer.periodic(
      const Duration(minutes: kPeriodicNotificationIntervalMinutes),
      (_) {
        debugPrint('[NotificationService] Timer disparado');
        _checkAndNotifyNextBackup();
      },
    );
  }

  /// Atualiza a lista de rotinas para notificações periódicas
  void updateRoutines(List<BackupRoutine> routines) {
    _routines = routines;
  }

  /// Verifica e notifica sobre o próximo backup
  void _checkAndNotifyNextBackup() {
    debugPrint('[NotificationService] Verificando próximo backup. Rotinas: ${_routines.length}');
    
    if (_routines.isEmpty) {
      debugPrint('[NotificationService] Nenhuma rotina encontrada');
      return;
    }

    DateTime? nextRunAt;
    String? nextRoutineName;

    for (final routine in _routines) {
      debugPrint('[NotificationService] Rotina: ${routine.name}, nextRunAt: ${routine.nextRunAt}');
      
      if (routine.nextRunAt == null) {
        continue;
      }

      if (nextRunAt == null || routine.nextRunAt!.isBefore(nextRunAt)) {
        nextRunAt = routine.nextRunAt;
        nextRoutineName = routine.name;
      }
    }

    if (nextRunAt != null && nextRoutineName != null) {
      notifyNextBackup(
        routineName: nextRoutineName,
        nextRunAt: nextRunAt,
      );
    } else {
      // Envia notificação de status quando não há backup agendado
      debugPrint('[NotificationService] Nenhum backup agendado, enviando notificação de status');
      _showNotification(
        id: kNextBackupNotificationId,
        title: 'ShadowSync Ativo',
        body: 'Você tem ${_routines.length} rotinas configuradas. Nenhum backup agendado no momento.',
        payload: 'status',
      );
    }
  }

  /// Para o timer de notificações periódicas
  void stopPeriodicNotifications() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
  }

  /// Cancela todas as notificações
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  /// Cancela uma notificação específica
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// Libera os recursos do serviço
  void dispose() {
    stopPeriodicNotifications();
  }
}
