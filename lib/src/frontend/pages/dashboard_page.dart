// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Página principal do dashboard, exibindo as rotinas de backup e status do sistema.
// ============================================================================

// ============================================================================
// IMPORTAÇÕES
// ============================================================================

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../backend/models/backup_routine.dart';
import '../../generated/l10n/app_localizations.dart';
import '../../backend/models/user_settings.dart';
import '../../backend/services/notification_service.dart';
import '../../backend/services/user_settings_service.dart';
import '../controllers/dashboard_controller.dart';
import 'new_backup_page.dart';
import 'settings_page.dart';
import '../theme/shadowsync_theme.dart';
import '../widgets/decryption_dialog.dart';
import '../widgets/disk_verification_dialog.dart';
import '../widgets/routine_card.dart';
import '../widgets/sidebar.dart';
import '../widgets/status_footer.dart';

// ============================================================================
// CONFIGURAÇÃO DE TIPOGRAFIA DO DASHBOARD
// ============================================================================

/// Fonte padrão usada em todos os textos do dashboard
const String kDashboardFontFamily = 'Roboto';

/// Peso da fonte para títulos
const FontWeight kDashboardTitleFontWeight = FontWeight.w700;

/// Peso da fonte para subtítulos
const FontWeight kDashboardSubtitleFontWeight = FontWeight.w600;

/// Peso da fonte para texto normal
const FontWeight kDashboardTextFontWeight = FontWeight.w500;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO DENSO (Mobile Portrait)
// ============================================================================

/// Tamanho da fonte do título principal (modo denso)
const double kDashboardTitleFontSizeDense = 22.0;

/// Tamanho da fonte do cabeçalho (modo denso)
const double kDashboardHeaderFontSizeDense = 18.0;

/// Tamanho da fonte do nome do usuário (modo denso)
const double kDashboardUserNameFontSizeDense = 16.0;

/// Padding horizontal do conteúdo (modo denso)
const double kDashboardContentPaddingHorizontalDense = 8.0;

/// Padding vertical do conteúdo (modo denso)
const double kDashboardContentPaddingVerticalDense = 8.0;

/// Padding horizontal da seção título (modo denso)
const double kDashboardTitleSectionPaddingDense = 14.0;

/// Padding horizontal do grid (modo denso)
const double kDashboardGridPaddingDense = 12.0;

/// Espaçamento do grid (modo denso)
const double kDashboardGridSpacingDense = 12.0;

/// Padding inferior do título de seção (modo denso)
const double kDashboardTitleBottomPaddingDense = 12.0;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO COMPACT (Tablet)
// ============================================================================

/// Tamanho da fonte do título principal (modo compact)
const double kDashboardTitleFontSizeCompact = 24.0;

/// Padding horizontal do conteúdo (modo compact)
const double kDashboardContentPaddingHorizontalCompact = 10.0;

/// Padding vertical do conteúdo (modo compact)
const double kDashboardContentPaddingVerticalCompact = 8.0;

/// Padding horizontal da seção título (modo compact)
const double kDashboardTitleSectionPaddingCompact = 16.0;

/// Padding horizontal do grid (modo compact)
const double kDashboardGridPaddingCompact = 14.0;

/// Padding top do título de seção (modo compact)
const double kDashboardTitleTopPaddingCompact = 10.0;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO NORMAL (Desktop)
// ============================================================================

/// Tamanho da fonte do título principal (modo normal)
const double kDashboardTitleFontSizeNormal = 28.0;

/// Padding horizontal do conteúdo (modo normal)
const double kDashboardContentPaddingHorizontalNormal = 12.0;

/// Padding horizontal direito do conteúdo (modo normal)
const double kDashboardContentPaddingRightNormal = 16.0;

/// Padding vertical do conteúdo (modo normal)
const double kDashboardContentPaddingVerticalNormal = 8.0;

/// Padding inferior do conteúdo (modo normal)
const double kDashboardContentPaddingBottomNormal = 14.0;

/// Padding horizontal da seção título (modo normal)
const double kDashboardTitleSectionPaddingNormal = 24.0;

/// Padding horizontal do grid (modo normal)
const double kDashboardGridPaddingNormal = 20.0;

/// Padding top do título de seção (modo normal)
const double kDashboardTitleTopPaddingNormal = 16.0;

/// Padding inferior do título de seção (modo normal)
const double kDashboardTitleBottomPaddingNormal = 16.0;

/// Espaçamento do grid (modo normal)
const double kDashboardGridSpacingNormal = 16.0;

// ============================================================================
// CONFIGURAÇÃO DE DIMENSÕES
// ============================================================================

/// Raio de borda do container principal
const double kDashboardBorderRadius = 20.0;

/// Raio de borda dos dialogs
const double kDashboardDialogBorderRadius = 16.0;

/// Largura do dialog de novo backup
const double kDashboardNewBackupDialogWidth = 760.0;

/// Altura do dialog de novo backup
const double kDashboardNewBackupDialogHeight = 680.0;

/// Padding horizontal do dialog de novo backup
const double kDashboardNewBackupDialogPaddingH = 100.0;

/// Padding vertical do dialog de novo backup
const double kDashboardNewBackupDialogPaddingV = 40.0;

/// Área livre para controles de janela do macOS
const double kDashboardMacWindowControlsArea = 40.0;

/// Intensidade do blur do backdrop
const double kDashboardBlurIntensity = 16.0;

// ============================================================================
// CONFIGURAÇÃO DE BREAKPOINTS
// ============================================================================

/// Breakpoint para identificar telefone
const double kDashboardPhoneBreakpoint = 700.0;

/// Breakpoint para identificar tablet
const double kDashboardTabletBreakpoint = 1100.0;

/// Largura mínima estimada de um card para cálculo de colunas
const double kDashboardCardMinWidth = 340.0;

/// Número máximo de colunas no grid
const int kDashboardMaxColumns = 3;

// ============================================================================
// CONFIGURAÇÃO DE ALTURA DOS CARDS
// ============================================================================

/// Altura fixa do card (telefone portrait)
const double kDashboardCardHeightPhonePortrait = 195.0;

/// Altura fixa do card (telefone landscape)
const double kDashboardCardHeightPhoneLandscape = 230.0;

/// Altura fixa do card (tablet portrait)
const double kDashboardCardHeightTabletPortrait = 220.0;

/// Altura fixa do card (tablet landscape)
const double kDashboardCardHeightTabletLandscape = 230.0;

/// Altura fixa do card (desktop)
const double kDashboardCardHeightDesktop = 220.0;

// ============================================================================
// CONFIGURAÇÃO DO AVATAR
// ============================================================================

/// Tamanho do avatar no modo mobile
const double kDashboardAvatarSize = 72.0;

/// Largura da borda do avatar
const double kDashboardAvatarBorderWidth = 2.0;

/// Tamanho da fonte das iniciais no avatar (fallback)
const double kDashboardAvatarInitialsFontSize = 28.0;

/// Blur radius do shadow do avatar
const double kDashboardAvatarShadowBlur = 12.0;

/// Spread radius do shadow do avatar
const double kDashboardAvatarShadowSpread = -2.0;

/// Opacidade do shadow do avatar
const double kDashboardAvatarShadowOpacity = 0.3;

/// Padding vertical da seção do avatar
const double kDashboardAvatarSectionPadding = 16.0;

/// Espaço entre avatar e nome
const double kDashboardAvatarNameSpacing = 8.0;

// ============================================================================
// CONFIGURAÇÃO DO MENU POPUP
// ============================================================================

/// Espaço entre ícone e texto no menu popup
const double kDashboardPopupMenuIconSpacing = 12.0;

// ============================================================================
// CONFIGURAÇÃO DO FOOTER
// ============================================================================

/// Padding top do footer
const double kDashboardFooterTopPadding = 10.0;

/// Padding bottom do footer
const double kDashboardFooterBottomPadding = 6.0;

// ============================================================================
// CONFIGURAÇÃO DE CORES DO DASHBOARD
// ============================================================================

/// Cor de início do gradiente do background
const Color kDashboardGradientStart = Color(0xFF0F172A);

/// Cor de fim do gradiente do background
const Color kDashboardGradientEnd = Color(0xFF020617);

/// Centro do gradiente radial
const Alignment kDashboardGradientCenter = Alignment(0.0, -0.2);

/// Raio do gradiente radial
const double kDashboardGradientRadius = 1.15;

// ============================================================================
// WIDGET DASHBOARD PAGE
// ============================================================================

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.controller});

  final DashboardController controller;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final Stream<List<BackupRoutine>> _routinesStream;
  Stream<Map<String, int?>>? _availableSpaceStream;
  Map<String, int?> _availableSpaceCache = {};
  List<BackupRoutine>? _initialRoutines;

  // Configurações do usuário
  UserSettingsService? _settingsService;
  UserSettings? _userSettings;

  // Serviço de notificações
  NotificationService? _notificationService;

  bool get _isDesktop => !Platform.isAndroid && !Platform.isIOS;
  bool get _isMacOS => Platform.isMacOS;

  @override
  void initState() {
    super.initState();
    _routinesStream = widget.controller.watchRoutines();
    _availableSpaceStream = widget.controller.watchAvailableSpace();
    _availableSpaceCache = widget.controller.availableSpaceCache;

    // Carrega configurações do usuário
    _loadUserSettings();

    // Carrega dados iniciais das rotinas
    _loadInitialRoutines();

    // Inicializa notificações periódicas
    _initNotifications();

    // Escuta atualizações de espaço em disco
    _availableSpaceStream?.listen((cache) {
      if (mounted) {
        setState(() => _availableSpaceCache = cache);
      }
    });
  }

  Future<void> _initNotifications() async {
    try {
      _notificationService = await NotificationService.getInstance();
      // Inicia notificações periódicas com a lista inicial de rotinas
      final routines = await widget.controller.getAllRoutines();
      _notificationService?.startPeriodicNotifications(routines);
    } catch (e) {
      debugPrint('[DashboardPage] Erro ao inicializar notificações: $e');
    }
  }

  /// Atualiza as rotinas no serviço de notificações
  void _updateNotificationRoutines(List<BackupRoutine> routines) {
    _notificationService?.updateRoutines(routines);
  }

  Future<void> _loadInitialRoutines() async {
    final routines = await widget.controller.getAllRoutines();
    if (mounted) {
      setState(() {
        _initialRoutines = routines;
      });
    }
  }

  @override
  void dispose() {
    _notificationService?.stopPeriodicNotifications();
    super.dispose();
  }

  Future<void> _loadUserSettings() async {
    _settingsService = await UserSettingsService.getInstance();
    if (mounted) {
      setState(() {
        _userSettings = _settingsService!.getSettings();
      });
    }
    // Escuta mudanças nas configurações
    _settingsService!.watchSettings().listen((settings) {
      if (mounted) {
        setState(() => _userSettings = settings);
      }
    });
  }

  Widget _buildAvatarFallback() {
    final initials = _userSettings?.getInitials() ?? 'U';
    return Container(
      color: ShadowSyncColors.primaryBackground,
      alignment: Alignment.center,
      child: Text(
        initials,
        style: const TextStyle(
          fontFamily: kDashboardFontFamily,
          color: ShadowSyncColors.accent,
          fontWeight: FontWeight.bold,
          fontSize: kDashboardAvatarInitialsFontSize,
        ),
      ),
    );
  }

  Future<void> _confirmAndDeleteRoutine(BackupRoutine routine) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ShadowSyncColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDashboardDialogBorderRadius),
            side: const BorderSide(color: ShadowSyncColors.border),
          ),
          title: Text(
            AppLocalizations.of(context).deleteRoutine,
            style: const TextStyle(
              fontFamily: kDashboardFontFamily,
              color: ShadowSyncColors.text,
              fontWeight: kDashboardSubtitleFontWeight,
            ),
          ),
          content: Text(
            AppLocalizations.of(context).deleteRoutineConfirm(routine.name),
            style: const TextStyle(
              fontFamily: kDashboardFontFamily,
              color: ShadowSyncColors.text,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                AppLocalizations.of(context).cancel,
                style: const TextStyle(
                  fontFamily: kDashboardFontFamily,
                  color: ShadowSyncColors.text,
                ),
              ),
            ),
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                backgroundColor:
                    Colors.redAccent.withAlpha((0xFF * 0.18).toInt()),
                foregroundColor: Colors.redAccent,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                AppLocalizations.of(context).delete,
                style: const TextStyle(fontFamily: kDashboardFontFamily),
              ),
            ),
          ],
        );
      },
    );

    if (result != true) {
      return;
    }

    await widget.controller.deleteRoutine(routine.id);
  }

  /// Executa um backup manual
  Future<void> _runManualBackup(BackupRoutine routine) async {
    // Mostra um snackbar informando que o backup foi iniciado
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).startingBackup(routine.name)),
          backgroundColor: ShadowSyncColors.accent,
          duration: const Duration(seconds: 2),
        ),
      );
    }
    
    // Executa o backup
    await widget.controller.runRoutine(routine.id);
  }

  Future<void> _openSettings() async {
    final result = await SettingsPage.show(
      context,
      // TODO: Carregar valores salvos das configurações
      // initialUserName: savedUserName,
      // initialAvatarUrl: savedAvatarUrl,
      // initialEncryptionPassword: savedPassword,
      // initialUseCustomBackupName: savedUseCustomName,
      // initialCustomBackupName: savedCustomName,
    );

    if (result != null) {
      // TODO: Salvar configurações
      // await saveSettings(result);
    }
  }

  /// Abre o dialog de verificação de disco.
  Future<void> _openDiskVerification() async {
    await DiskVerificationDialog.show(context);
  }

  /// Abre o dialog de descriptografia.
  Future<void> _openDecryption() async {
    await DecryptionDialog.show(context);
  }

  /// Abre o dialog Sobre.
  Future<void> _openAbout() async {
    final l10n = AppLocalizations.of(context);
    
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ShadowSyncColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: ShadowSyncColors.border),
          ),
          title: Text(
            l10n.aboutTitle,
            style: TextStyle(
              color: ShadowSyncColors.text,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Versão
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${l10n.version}:',
                        style: TextStyle(
                          color: ShadowSyncColors.text.withAlpha((0xFF * 0.7).toInt()),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '1.0.0',
                        style: TextStyle(
                          color: ShadowSyncColors.text,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 24),
                // Desenvolvedor
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${l10n.developer}:',
                        style: TextStyle(
                          color: ShadowSyncColors.text.withAlpha((0xFF * 0.7).toInt()),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Eng. H. Bianchi',
                        style: TextStyle(
                          color: ShadowSyncColors.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: TextStyle(color: ShadowSyncColors.accent),
              ),
            ),
            TextButton(
              onPressed: _launchWebsite,
              child: Text(
                l10n.visitWebsite,
                style: TextStyle(color: ShadowSyncColors.accent),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Abre o website no navegador padrão.
  Future<void> _launchWebsite() async {
    final Uri url = Uri.parse('https://infinitemaker.com.br');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('[DashboardPage] Erro ao abrir URL: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Não foi possível abrir o site'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  Future<void> _openNewBackupFlow({required bool isCompact}) async {
    BackupRoutine? createdRoutine;

    if (isCompact) {
      createdRoutine = await Navigator.of(context).push<BackupRoutine>(
        MaterialPageRoute(
          builder: (_) => const NewBackupPage(),
          fullscreenDialog: true,
        ),
      );
    } else {
      createdRoutine = await showDialog<BackupRoutine>(
        context: context,
        builder: (_) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: kDashboardNewBackupDialogPaddingH,
              vertical: kDashboardNewBackupDialogPaddingV,
            ),
            backgroundColor: Colors.transparent,
            child: SizedBox(
              width: kDashboardNewBackupDialogWidth,
              height: kDashboardNewBackupDialogHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(kDashboardBorderRadius),
                child: const NewBackupPage(),
              ),
            ),
          );
        },
      );
    }

    if (createdRoutine == null) {
      return;
    }

    await widget.controller.createRoutine(createdRoutine);

    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: kDashboardGradientCenter,
            radius: kDashboardGradientRadius,
            colors: [kDashboardGradientStart, kDashboardGradientEnd],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final orientation = MediaQuery.of(context).orientation;
              final isLandscape = orientation == Orientation.landscape;
              final isPhone = width < kDashboardPhoneBreakpoint;
              final isTablet = width >= kDashboardPhoneBreakpoint && width < kDashboardTabletBreakpoint;
              final isCompact = isPhone || (isTablet && !isLandscape);
              final isPhonePortrait = isPhone && !isLandscape;
              final showSidebar = !isPhone && !isTablet;

              final contentPadding = isPhonePortrait
                  ? EdgeInsets.fromLTRB(
                      kDashboardContentPaddingHorizontalDense,
                      kDashboardContentPaddingVerticalDense,
                      kDashboardContentPaddingHorizontalDense,
                      kDashboardFooterTopPadding,
                    )
                  : isCompact
                      ? EdgeInsets.fromLTRB(
                          kDashboardContentPaddingHorizontalCompact,
                          kDashboardContentPaddingVerticalCompact,
                          kDashboardContentPaddingHorizontalCompact,
                          kDashboardFooterTopPadding,
                        )
                      : EdgeInsets.fromLTRB(
                          kDashboardContentPaddingHorizontalNormal,
                          kDashboardContentPaddingVerticalNormal,
                          kDashboardContentPaddingRightNormal,
                          kDashboardContentPaddingBottomNormal,
                        );

              final estimatedContentWidth = width - (showSidebar ? 148 : 0);
              final estimatedColumnsByWidth =
                  (estimatedContentWidth / kDashboardCardMinWidth).floor().clamp(1, kDashboardMaxColumns);

              int crossAxisCount;
              if (isPhone) {
                crossAxisCount = isLandscape ? 2 : 1;
              } else if (isTablet) {
                crossAxisCount = isLandscape
                    ? estimatedColumnsByWidth.clamp(1, 2)
                    : 2;
              } else {
                crossAxisCount = 2;
              }

              final cardHeight = isPhonePortrait
                  ? kDashboardCardHeightPhonePortrait
                  : isPhone
                      ? kDashboardCardHeightPhoneLandscape
                      : isTablet
                      ? (isLandscape ? kDashboardCardHeightTabletLandscape : kDashboardCardHeightTabletPortrait)
                          : kDashboardCardHeightDesktop;

              final gridSpacing = isPhonePortrait ? kDashboardGridSpacingDense : kDashboardGridSpacingNormal;

              final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: gridSpacing,
                mainAxisSpacing: gridSpacing,
                mainAxisExtent: cardHeight,
              );

              return Column(
                children: [
                  if (_isMacOS)
                    GestureDetector(
                      onPanStart: _isDesktop
                          ? (_) => windowManager.startDragging()
                          : null,
                      child: const SizedBox(height: kDashboardMacWindowControlsArea),
                    ),
                  Expanded(
                    child: Row(
                      children: [
                        if (showSidebar)
                          ShadowSyncSidebar(
                            avatarPath: _userSettings?.avatarPath,
                            userName: _userSettings?.userName,
                            onSettingsPressed: () => _openSettings(),
                            onVerifyDiskPressed: () => _openDiskVerification(),
                            onDecryptPressed: () => _openDecryption(),
                            onAboutPressed: () => _openAbout(),
                          ),
                        Expanded(
                          child: Padding(
                            padding: contentPadding,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(kDashboardBorderRadius),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: kDashboardBlurIntensity, sigmaY: kDashboardBlurIntensity),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: ShadowSyncColors.overlay,
                                    borderRadius: BorderRadius.circular(kDashboardBorderRadius),
                                    border: Border.all(
                                      color: ShadowSyncColors.border,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      if (isCompact)
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                            isPhonePortrait ? kDashboardTitleSectionPaddingDense : kDashboardTitleSectionPaddingCompact,
                                            kDashboardAvatarSectionPadding,
                                            isPhonePortrait ? kDashboardTitleSectionPaddingDense : kDashboardTitleSectionPaddingCompact,
                                            0,
                                          ),
                                          child: Row(
                                            children: [
                                              // Widget invisível para balancear o PopupMenuButton e centralizar o título
                                              const SizedBox(width: 48),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    AppLocalizations.of(context).appTitle,
                                                    style: const TextStyle(
                                                      fontFamily: kDashboardFontFamily,
                                                      color: ShadowSyncColors.text,
                                                      fontSize: kDashboardHeaderFontSizeDense,
                                                      fontWeight: kDashboardSubtitleFontWeight,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuButton<String>(
                                                icon: const Icon(
                                                  Icons.more_vert,
                                                  color: ShadowSyncColors.text,
                                                ),
                                                color: ShadowSyncColors.secondary,
                                                onSelected: (value) {
                                                  switch (value) {
                                                    case 'verify_disk':
                                                      _openDiskVerification();
                                                      break;
                                                    case 'decrypt':
                                                      _openDecryption();
                                                      break;
                                                    case 'about':
                                                      _openAbout();
                                                      break;
                                                    case 'settings':
                                                      _openSettings();
                                                      break;
                                                  }
                                                },
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'verify_disk',
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Icon(Icons.disc_full_outlined, color: ShadowSyncColors.text),
                                                        SizedBox(width: kDashboardPopupMenuIconSpacing),
                                                        Text(AppLocalizations.of(context).verifyDisk, style: const TextStyle(fontFamily: kDashboardFontFamily, color: ShadowSyncColors.text)),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'decrypt',
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Icon(Icons.lock_open_outlined, color: ShadowSyncColors.text),
                                                        SizedBox(width: kDashboardPopupMenuIconSpacing),
                                                        Text(AppLocalizations.of(context).decrypt, style: const TextStyle(fontFamily: kDashboardFontFamily, color: ShadowSyncColors.text)),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    value: 'about',
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Icon(Icons.info_outline, color: ShadowSyncColors.text),
                                                        SizedBox(width: kDashboardPopupMenuIconSpacing),
                                                        Text(AppLocalizations.of(context).about, style: const TextStyle(fontFamily: kDashboardFontFamily, color: ShadowSyncColors.text)),
                                                      ],
                                                    ),
                                                  ),
                                                  const PopupMenuDivider(),
                                                  PopupMenuItem(
                                                    value: 'settings',
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Icon(Icons.settings_outlined, color: ShadowSyncColors.text),
                                                        SizedBox(width: kDashboardPopupMenuIconSpacing),
                                                        Text(AppLocalizations.of(context).settings, style: const TextStyle(fontFamily: kDashboardFontFamily, color: ShadowSyncColors.text)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      // Avatar do usuário para dispositivos móveis
                                      if (isCompact)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: kDashboardAvatarSectionPadding),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: kDashboardAvatarSize,
                                                height: kDashboardAvatarSize,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: ShadowSyncColors.accent,
                                                    width: kDashboardAvatarBorderWidth,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: ShadowSyncColors.accent.withOpacityFixed(kDashboardAvatarShadowOpacity),
                                                      blurRadius: kDashboardAvatarShadowBlur,
                                                      spreadRadius: kDashboardAvatarShadowSpread,
                                                    ),
                                                  ],
                                                ),
                                                child: ClipOval(
                                                  child: _userSettings?.avatarPath != null && _userSettings!.avatarPath!.isNotEmpty
                                                      ? Image.file(
                                                          File(_userSettings!.avatarPath!),
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (_, __, ___) => _buildAvatarFallback(),
                                                        )
                                                      : _buildAvatarFallback(),
                                                ),
                                              ),
                                              if (_userSettings?.userName != null && _userSettings!.userName!.isNotEmpty)
                                                Padding(
                                                  padding: const EdgeInsets.only(top: kDashboardAvatarNameSpacing),
                                                  child: Text(
                                                    _userSettings!.userName!,
                                                    style: const TextStyle(
                                                      fontFamily: kDashboardFontFamily,
                                                      color: ShadowSyncColors.text,
                                                      fontSize: kDashboardUserNameFontSizeDense,
                                                      fontWeight: kDashboardTextFontWeight,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                          isPhonePortrait ? kDashboardTitleSectionPaddingDense : (isCompact ? kDashboardTitleSectionPaddingCompact : kDashboardTitleSectionPaddingNormal),
                                          isCompact ? kDashboardTitleTopPaddingCompact : kDashboardTitleTopPaddingNormal,
                                          isPhonePortrait ? kDashboardTitleSectionPaddingDense : (isCompact ? kDashboardTitleSectionPaddingCompact : kDashboardTitleSectionPaddingNormal),
                                          isPhonePortrait ? kDashboardTitleBottomPaddingDense : kDashboardTitleBottomPaddingNormal,
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context).myRoutines,
                                            style: TextStyle(
                                              fontFamily: kDashboardFontFamily,
                                              fontSize: isPhonePortrait
                                                  ? kDashboardTitleFontSizeDense
                                                  : (isCompact ? kDashboardTitleFontSizeCompact : kDashboardTitleFontSizeNormal),
                                              fontWeight: kDashboardTitleFontWeight,
                                              color: ShadowSyncColors.text,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: isPhonePortrait
                                                ? kDashboardGridPaddingDense
                                                : (isCompact ? kDashboardGridPaddingCompact : kDashboardGridPaddingNormal),
                                          ),
                                          child: StreamBuilder<List<BackupRoutine>>(
                                            stream: _routinesStream,
                                            initialData: _initialRoutines,
                                            builder: (context, snapshot) {
                                              // Mostra loading apenas se não tivermos dados iniciais nem do stream
                                              if (!snapshot.hasData && _initialRoutines == null) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }

                                              final routines = snapshot.data ?? _initialRoutines ?? [];
                                              
                                              // Atualiza as rotinas no serviço de notificações
                                              _updateNotificationRoutines(routines);
                                              
                                              return Column(
                                                children: [
                                                  Expanded(
                                                    child: GridView.builder(
                                                      gridDelegate: gridDelegate,
                                                      itemCount: routines.length,
                                                      itemBuilder: (context, index) {
                                                        final routine = routines[index];
                                                        final availableSpace = _availableSpaceCache[routine.destinationPath];
                                                        return RoutineCard(
                                                          routine: routine,
                                                          isDense: isPhonePortrait,
                                                          onDelete: () {
                                                            _confirmAndDeleteRoutine(routine);
                                                          },
                                                          availableSpace: availableSpace,
                                                          onManualRun: routine.scheduleType == ScheduleType.manual
                                                              ? () => _runManualBackup(routine)
                                                              : null,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: kDashboardFooterTopPadding,
                                                      bottom: kDashboardFooterBottomPadding,
                                                    ),
                                                    child: StatusFooter(
                                                      isCompact: isCompact,
                                                      isPhonePortrait: isPhonePortrait,
                                                      routines: routines,
                                                      onNewBackupPressed: () {
                                                        _openNewBackupFlow(
                                                          isCompact: isCompact,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
