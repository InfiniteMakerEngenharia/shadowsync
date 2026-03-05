import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'backend/repositories/backup_repository.dart';
import 'backend/repositories/in_memory_backup_repository.dart';
import 'backend/services/backup_service.dart';
import 'backend/services/disk_monitor_service.dart';
import 'backend/services/locale_service.dart';
import 'frontend/controllers/dashboard_controller.dart';
import 'frontend/pages/dashboard_page.dart';
import 'frontend/pages/splash_screen_page.dart';
import 'frontend/theme/shadowsync_theme.dart';
import 'generated/l10n/app_localizations.dart';

class ShadowSyncApp extends StatefulWidget {
  const ShadowSyncApp({
    super.key,
    this.repository,
    this.backupService,
    this.showSplash = true,
  });

  final BackupRepository? repository;
  final BackupService? backupService;

  /// Se true, mostra a splash screen ao iniciar.
  final bool showSplash;

  @override
  State<ShadowSyncApp> createState() => _ShadowSyncAppState();
}

class _ShadowSyncAppState extends State<ShadowSyncApp> with WidgetsBindingObserver {
  late final BackupRepository _repository;
  late final BackupService _service;
  late final DiskMonitorService _diskMonitorService;
  late final DashboardController _controller;
  late final LocaleService _localeService;

  @override
  void initState() {
    super.initState();
    
    // Adiciona observer para detectar mudanças de estado do app (background/foreground)
    WidgetsBinding.instance.addObserver(this);
    
    _repository = widget.repository ?? InMemoryBackupRepository();
    _service = widget.backupService ?? BackupService(_repository);
    _diskMonitorService = DiskMonitorService(_service);
    _controller = DashboardController(
      _service,
      diskMonitorService: _diskMonitorService,
    );
    // Obtém a instância singleton do LocaleService
    _localeService = LocaleService.getInstance();

    // Inicia monitoramento de espaço em disco
    _diskMonitorService.start();
    
    // Inicializa o serviço de localização de forma assíncrona
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _localeService.initialize();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Quando o app volta do background, recarrega os dados do disco
    if (state == AppLifecycleState.resumed) {
      debugPrint('[ShadowSyncApp] App retomado - recarregando dados do disco');
      _repository.reload().then((_) {
        // Força atualização da UI
        _controller.refresh();
      }).catchError((e) {
        debugPrint('[ShadowSyncApp] Erro ao recarregar dados: $e');
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _diskMonitorService.dispose();
    _localeService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _localeService,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ShadowSync',
          theme: buildShadowSyncTheme(),
          
          // Configuração de internacionalização
          locale: _localeService.currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LocaleService.supportedLocales,
          localeResolutionCallback: LocaleService.localeResolutionCallback,
          
          home: widget.showSplash
              ? _SplashWrapper(
                  onComplete: () => _navigateToDashboard(context),
                  controller: _controller,
                  localeService: _localeService,
                )
              : DashboardPage(controller: _controller),
        );
      },
    );
  }

  void _navigateToDashboard(BuildContext context) {
    // A navegação será feita pelo _SplashWrapper
  }
}

// ============================================================================
// SPLASH WRAPPER
// ============================================================================

/// Widget wrapper que gerencia a transição da splash para o dashboard.
class _SplashWrapper extends StatefulWidget {
  const _SplashWrapper({
    required this.onComplete,
    required this.controller,
    required this.localeService,
  });

  final VoidCallback onComplete;
  final DashboardController controller;
  final LocaleService localeService;

  @override
  State<_SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<_SplashWrapper> {
  bool _showDashboard = false;

  void _onSplashComplete() {
    setState(() {
      _showDashboard = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showDashboard) {
      return DashboardPage(controller: widget.controller);
    }

    return SplashScreenPage(
      config: const SplashScreenConfig(
        riveAssetPath: 'assets/animations/splash.riv',
        minDisplayDuration: Duration(seconds: 2),
        maxDisplayDuration: Duration(seconds: 5),
      ),
      onComplete: _onSplashComplete,
    );
  }
}
