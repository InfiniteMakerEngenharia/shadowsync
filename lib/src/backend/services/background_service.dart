import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/email_notification_config.dart';
import '../models/telegram_notification_config.dart';
import '../models/user_settings.dart';
import '../repositories/hive_backup_repository.dart';
import 'backup_service.dart';
import 'local_storage_service.dart';
import 'notification_localizations.dart';
import 'scheduler_service.dart';

/// Serviço para manter o app funcionando em segundo plano no Android.
class BackgroundServiceManager {
  BackgroundServiceManager._();

  static BackgroundServiceManager? _instance;
  static final FlutterBackgroundService _service = FlutterBackgroundService();

  /// Obtém a instância singleton
  static BackgroundServiceManager getInstance() {
    _instance ??= BackgroundServiceManager._();
    return _instance!;
  }

  /// Verifica se deve usar o serviço de background (apenas Android/iOS)
  bool get _shouldUseBackgroundService => Platform.isAndroid || Platform.isIOS;

  /// Inicializa o serviço de background
  Future<void> initialize() async {
    if (!_shouldUseBackgroundService) {
      return;
    }

    final l10n = NotificationLocalizations.getInstance();

    // Cria o canal de notificação primeiro (obrigatório no Android 8+)
    if (Platform.isAndroid) {
      await _createNotificationChannel(l10n);
    }

    await _service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: _onStart,
        autoStart: false, // Desabilitado - iniciamos manualmente
        autoStartOnBoot: true,
        isForegroundMode: true,
        notificationChannelId: 'shadowsync_background',
        initialNotificationTitle: l10n.backgroundServiceNotificationTitle,
        initialNotificationContent: l10n.backgroundServiceNotificationContent,
        foregroundServiceNotificationId: 888,
        foregroundServiceTypes: [AndroidForegroundType.dataSync],
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: _onStart,
        onBackground: _onIosBackground,
      ),
    );
  }

  /// Cria o canal de notificação para o serviço de foreground
  Future<void> _createNotificationChannel(NotificationLocalizations l10n) async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final channel = AndroidNotificationChannel(
      'shadowsync_background', // ID do canal - deve ser o mesmo do serviço
      l10n.backgroundServiceChannelName,
      description: l10n.backgroundServiceChannelDescription,
      importance: Importance.low, // Low para não incomodar o usuário
      playSound: false,
      enableVibration: false,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Inicia o serviço de background
  Future<void> startService() async {
    if (!_shouldUseBackgroundService) {
      return;
    }

    final isRunning = await _service.isRunning();
    if (!isRunning) {
      await _service.startService();
    }
  }

  /// Para o serviço de background
  Future<void> stopService() async {
    if (!_shouldUseBackgroundService) {
      return;
    }

    final isRunning = await _service.isRunning();
    if (isRunning) {
      _service.invoke('stopService');
    }
  }

  /// Verifica se o serviço está rodando
  Future<bool> isRunning() async {
    if (!_shouldUseBackgroundService) {
      return false;
    }
    return await _service.isRunning();
  }
}

/// Callback executado quando o serviço de background inicia
@pragma('vm:entry-point')
Future<void> _onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  // Inicializa o Hive no contexto de background
  await _initializeHiveInBackground();

  SchedulerService? schedulerService;

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) async {
    await schedulerService?.dispose();
    await service.stopSelf();
  });

  // Configura o serviço de agendamento
  try {
    final storageService = await LocalStorageService.create();
    final repository = HiveBackupRepository(
      storageService,
      seedData: const [],
    );
    
    final backupService = BackupService(repository);

    schedulerService = SchedulerService(backupService);
    await schedulerService.start();

    // Mantém o serviço rodando
    Timer.periodic(const Duration(seconds: 30), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          service.setForegroundNotificationInfo(
            title: 'ShadowSync',
            content: 'Monitorando backups agendados',
          );
        }
      }

      // Notifica a UI (se estiver aberta) que o serviço está ativo
      service.invoke('update', {
        'isRunning': true,
        'timestamp': DateTime.now().toIso8601String(),
      });
    });
  } catch (e) {
    debugPrint('[BackgroundService] Erro ao inicializar: $e');
  }
}

/// Callback para iOS em background
@pragma('vm:entry-point')
Future<bool> _onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

/// Inicializa o Hive no contexto de background
Future<void> _initializeHiveInBackground() async {
  try {
    await Hive.initFlutter();
    
    // Registra os adapters (necessário em cada isolate)
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(UserSettingsAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(TelegramNotificationConfigAdapter());
    }
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(EmailNotificationConfigAdapter());
    }
  } catch (e) {
    debugPrint('[BackgroundService] Erro ao inicializar Hive: $e');
  }
}
