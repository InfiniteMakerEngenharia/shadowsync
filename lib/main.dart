import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:window_manager/window_manager.dart';

import 'src/app.dart';
import 'src/backend/models/email_notification_config.dart';
import 'src/backend/models/user_settings.dart';
import 'src/backend/models/telegram_notification_config.dart';
import 'src/backend/repositories/backup_repository.dart';
import 'src/backend/repositories/hive_backup_repository.dart';
import 'src/backend/repositories/in_memory_backup_repository.dart';
import 'src/backend/services/backup_service.dart';
import 'src/backend/services/background_service.dart';
import 'src/backend/services/local_storage_service.dart';
import 'src/backend/services/permission_service.dart';
import 'src/backend/services/scheduler_service.dart';
import 'src/backend/services/tray_service.dart';

SchedulerService? _schedulerService;
TrayService? _trayService;
BackgroundServiceManager? _backgroundService;

Future<void> main() async {
  // Captura erros de Flutter
  FlutterError.onError = (details) {
    debugPrint('[FlutterError] ${details.exception}');
    debugPrint('[FlutterError] ${details.stack}');
  };
  
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Hive - usa initFlutter para mobile (path_provider) ou path manual para desktop
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      await Hive.initFlutter();
    } else {
      final hivePath = _getHivePath();
      await Directory(hivePath).create(recursive: true);
      Hive.init(hivePath);
    }
  } catch (e) {
    debugPrint('[Main] Erro ao inicializar Hive: $e');
  }
  
  // Registra adapters do Hive
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(UserSettingsAdapter());
  }
  if (!Hive.isAdapterRegistered(4)) {
    Hive.registerAdapter(TelegramNotificationConfigAdapter());
  }
  if (!Hive.isAdapterRegistered(5)) {
    Hive.registerAdapter(EmailNotificationConfigAdapter());
  }

  BackupRepository repository = InMemoryBackupRepository();
  try {
    final storageService = await LocalStorageService.create();
    repository = HiveBackupRepository(
      storageService,
      seedData: const [],
    );
  } catch (e) {
    debugPrint('[Main] Erro ao criar repository: $e');
    repository = InMemoryBackupRepository();
  }

  final backupService = BackupService(repository);
  _schedulerService = SchedulerService(backupService);
  
  try {
    await _schedulerService?.start();
  } catch (e) {
    debugPrint('[Main] Erro ao iniciar scheduler: $e');
  }

  // Configura o serviço de background para Android/iOS (apenas inicializa, não inicia)
  if (Platform.isAndroid || Platform.isIOS) {
    try {
      _backgroundService = BackgroundServiceManager.getInstance();
      await _backgroundService?.initialize();
    } catch (e) {
      debugPrint('[Main] Erro ao inicializar background service: $e');
    }
  }

  if (!Platform.isAndroid && !Platform.isIOS) {
    await windowManager.ensureInitialized();

    // Configura esconder na bandeja ao fechar ANTES de iniciar a UI
    _trayService = TrayService();
    await _trayService?.setupWindowListener();
  }

  runApp(ShadowSyncApp(repository: repository, backupService: backupService));

  // Solicita permissões e inicia serviço de background no Android APÓS a UI iniciar
  if (Platform.isAndroid) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const permissionService = PermissionService();
      await permissionService.requestStoragePermissions();
      // Solicita permissão para ignorar otimizações de bateria (importante para background)
      await permissionService.requestIgnoreBatteryOptimizations();
      
      // Inicia o serviço de background APÓS as permissões e UI estarem prontas
      try {
        await _backgroundService?.startService();
      } catch (e) {
        debugPrint('[Main] Erro ao iniciar background service: $e');
      }
    });
  }

  if (!Platform.isAndroid && !Platform.isIOS) {
    const windowOptions = WindowOptions(
      size: Size(1280, 800),
      minimumSize: Size(1040, 680),
      maximumSize: Size(1280, 800),
      center: true,
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.hidden,
      title: 'ShadowSync',
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();

      // Inicializa o ícone da bandeja (já com listener configurado)
      await _trayService?.initializeTray();
    });
  }
}

/// Obtém o caminho para armazenamento do Hive baseado na plataforma (apenas desktop)
String _getHivePath() {
  final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'] ?? '.';
  
  if (Platform.isMacOS) {
    return p.join(home, 'Library', 'Application Support', 'shadowsync', 'hive');
  } else if (Platform.isLinux) {
    return p.join(home, '.local', 'share', 'shadowsync', 'hive');
  } else if (Platform.isWindows) {
    final appData = Platform.environment['APPDATA'] ?? home;
    return p.join(appData, 'shadowsync', 'hive');
  }
  
  return p.join(home, 'shadowsync', 'hive');
}
