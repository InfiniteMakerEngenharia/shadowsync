// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Widget dialog para verificação de integridade de discos.
// ============================================================================

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../backend/models/disk_info.dart';
import '../../backend/services/disk_verification_service.dart';
import '../../generated/l10n/app_localizations.dart';
import '../theme/shadowsync_theme.dart';

// ============================================================================
// CONFIGURAÇÃO DE DIMENSÕES
// ============================================================================

/// Largura do dialog (desktop)
const double kDiskDialogWidth = 600.0;

/// Altura máxima do dialog
const double kDiskDialogMaxHeight = 700.0;

/// Breakpoint para mobile
const double kDiskMobileBreakpoint = 600.0;

/// Padding interno do dialog
const double kDiskDialogPadding = 24.0;

/// Padding interno do dialog (mobile)
const double kDiskDialogPaddingMobile = 16.0;

/// Raio de borda do dialog
const double kDiskDialogBorderRadius = 20.0;

/// Tamanho do ícone de disco
const double kDiskIconSize = 40.0;

/// Altura de cada item de disco
const double kDiskItemHeight = 72.0;

/// Raio de borda dos itens
const double kDiskItemBorderRadius = 12.0;

/// Tamanho do ícone de status do teste
const double kTestStatusIconSize = 24.0;

// ============================================================================
// WIDGET PRINCIPAL
// ============================================================================

/// Dialog para verificação de integridade de discos.
/// 
/// Exibe uma lista de discos disponíveis e permite executar
/// testes de verificação em cada um.
class DiskVerificationDialog extends StatefulWidget {
  const DiskVerificationDialog({super.key});

  /// Exibe o dialog de verificação de disco.
  static Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const DiskVerificationDialog(),
    );
  }

  @override
  State<DiskVerificationDialog> createState() => _DiskVerificationDialogState();
}

class _DiskVerificationDialogState extends State<DiskVerificationDialog> {
  late DiskVerificationService _service;
  
  List<DiskInfo>? _disks;
  bool _isLoadingDisks = true;
  bool _isVerifying = false;
  String? _loadingError;
  
  DiskInfo? _selectedDisk;
  DiskVerificationResult? _verificationResult;
  StreamSubscription<DiskVerificationResult>? _verificationSubscription;
  bool _localizationInitialized = false;

  @override
  void initState() {
    super.initState();
    // Inicializa o serviço sem localizations primeiro
    _service = DiskVerificationService.getInstance();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Inicializa as localizações após o widget estar na árvore
    if (!_localizationInitialized) {
      _localizationInitialized = true;
      _service = DiskVerificationService.getInstance(
        localizations: AppLocalizations.of(context),
      );
      _loadDisks();
    }
  }

  @override
  void dispose() {
    _verificationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadDisks() async {
    setState(() {
      _isLoadingDisks = true;
      _loadingError = null;
    });

    try {
      final disks = await _service.listDisks();
      if (mounted) {
        setState(() {
          _disks = disks;
          _isLoadingDisks = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingError = 'Erro ao carregar discos: $e';
          _isLoadingDisks = false;
        });
      }
    }
  }

  void _selectDisk(DiskInfo disk) {
    setState(() {
      _selectedDisk = disk;
      _verificationResult = null;
    });
  }

  Future<void> _startVerification() async {
    if (_selectedDisk == null) return;

    setState(() {
      _isVerifying = true;
      _verificationResult = null;
    });

    _verificationSubscription?.cancel();
    _verificationSubscription = _service.verifyDisk(_selectedDisk!).listen(
      (result) {
        if (mounted) {
          setState(() {
            _verificationResult = result;
          });
        }
      },
      onDone: () {
        if (mounted) {
          setState(() {
            _isVerifying = false;
          });
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            _isVerifying = false;
          });
        }
      },
    );
  }

  void _backToSelection() {
    _verificationSubscription?.cancel();
    setState(() {
      _selectedDisk = null;
      _verificationResult = null;
      _isVerifying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < kDiskMobileBreakpoint;
        final padding = isMobile ? kDiskDialogPaddingMobile : kDiskDialogPadding;
        
        final dialogContent = ClipRRect(
          borderRadius: isMobile 
              ? BorderRadius.zero 
              : BorderRadius.circular(kDiskDialogBorderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              width: isMobile ? double.infinity : kDiskDialogWidth,
              height: isMobile ? double.infinity : null,
              constraints: isMobile 
                  ? null 
                  : const BoxConstraints(maxHeight: kDiskDialogMaxHeight),
              decoration: BoxDecoration(
                color: ShadowSyncColors.secondary.withOpacityFixed(0.95),
                borderRadius: isMobile 
                    ? BorderRadius.zero 
                    : BorderRadius.circular(kDiskDialogBorderRadius),
                border: isMobile ? null : Border.all(color: ShadowSyncColors.border),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    _buildHeader(padding: padding),
                    Flexible(
                      child: _selectedDisk == null
                          ? _buildDiskSelection(padding: padding)
                          : _buildVerificationView(padding: padding),
                    ),
                    _buildFooter(padding: padding, isMobile: isMobile),
                  ],
                ),
              ),
            ),
          ),
        );
        
        if (isMobile) {
          return Material(
            color: Colors.transparent,
            child: dialogContent,
          );
        }
        
        return Dialog(
          backgroundColor: Colors.transparent,
          child: dialogContent,
        );
      },
    );
  }

  Widget _buildHeader({required double padding}) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ShadowSyncColors.accent.withOpacityFixed(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.disc_full_outlined,
              color: ShadowSyncColors.accent,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedDisk == null
                      ? l10n.verifyDisk
                      : l10n.verifying(_selectedDisk!.name),
                  style: const TextStyle(
                    color: ShadowSyncColors.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _selectedDisk == null
                      ? l10n.selectDiskToVerify
                      : _selectedDisk!.mountPoint,
                  style: TextStyle(
                    color: ShadowSyncColors.text.withOpacityFixed(0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          if (_selectedDisk != null && !_isVerifying)
            IconButton(
              onPressed: _backToSelection,
              icon: const Icon(
                Icons.arrow_back,
                color: ShadowSyncColors.text,
              ),
              tooltip: l10n.backToSelection,
            ),
        ],
      ),
    );
  }

  Widget _buildDiskSelection({required double padding}) {
    final l10n = AppLocalizations.of(context);
    if (_isLoadingDisks) {
      return Padding(
        padding: EdgeInsets.all(padding * 2),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: ShadowSyncColors.accent),
              const SizedBox(height: 16),
              Text(
                l10n.loadingDisks,
                style: const TextStyle(color: ShadowSyncColors.text),
              ),
            ],
          ),
        ),
      );
    }

    if (_loadingError != null) {
      return Padding(
        padding: EdgeInsets.all(padding),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red.shade400,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                _loadingError!,
                style: const TextStyle(color: ShadowSyncColors.text),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadDisks,
                icon: const Icon(Icons.refresh),
                label: Text(l10n.tryAgain),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ShadowSyncColors.accent,
                  foregroundColor: ShadowSyncColors.text,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_disks == null || _disks!.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(padding * 2),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.storage_outlined,
                color: ShadowSyncColors.text,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                l10n.noDisksFound,
                style: const TextStyle(color: ShadowSyncColors.text),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(padding),
      itemCount: _disks!.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _DiskListItem(
        disk: _disks![index],
        onTap: () => _selectDisk(_disks![index]),
      ),
    );
  }

  Widget _buildVerificationView({required double padding}) {
    final l10n = AppLocalizations.of(context);
    if (_verificationResult == null && !_isVerifying) {
      // Aguardando iniciar verificação
      return SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DiskInfoCard(disk: _selectedDisk!, l10n: l10n),
            const SizedBox(height: 24),
            Text(
              l10n.testsToRun,
              style: const TextStyle(
                color: ShadowSyncColors.text,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...DiskVerificationTest.values.map((test) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: ShadowSyncColors.accent,
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _getTestDescription(test, l10n),
                    style: TextStyle(
                      color: ShadowSyncColors.text.withOpacityFixed(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      );
    }

    // Mostra progresso ou resultados
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_verificationResult != null) ...[
            // Status geral
            _buildOverallStatus(l10n),
            const SizedBox(height: 24),
            // Lista de testes
            Text(
              l10n.testResults,
              style: const TextStyle(
                color: ShadowSyncColors.text,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ..._verificationResult!.tests.map((test) => _buildTestResult(test, l10n)),
          ],
        ],
      ),
    );
  }

  String _getTestDescription(DiskVerificationTest test, AppLocalizations l10n) {
    switch (test) {
      case DiskVerificationTest.accessibility:
        return l10n.testAccessibilityCheck;
      case DiskVerificationTest.spaceAnalysis:
        return l10n.testSpaceAnalysis;
      case DiskVerificationTest.readTest:
        return l10n.testReadTest;
      case DiskVerificationTest.fileSystemCheck:
        return l10n.testFileSystemCheck;
      case DiskVerificationTest.smartStatus:
        return l10n.testSmartStatus;
    }
  }

  Widget _buildOverallStatus(AppLocalizations l10n) {
    final result = _verificationResult!;
    
    Color statusColor;
    IconData statusIcon;
    String statusText;
    
    switch (result.overallStatus) {
      case DiskTestStatus.running:
        statusColor = ShadowSyncColors.accent;
        statusIcon = Icons.sync;
        statusText = l10n.verificationInProgress;
        break;
      case DiskTestStatus.passed:
        statusColor = ShadowSyncColors.success;
        statusIcon = Icons.check_circle;
        statusText = l10n.diskVerifiedNoProblems;
        break;
      case DiskTestStatus.warning:
        statusColor = Colors.orange;
        statusIcon = Icons.warning_amber;
        statusText = l10n.verificationCompletedWithWarnings;
        break;
      case DiskTestStatus.failed:
        statusColor = Colors.red.shade400;
        statusIcon = Icons.error;
        statusText = l10n.problemsDetected;
        break;
      default:
        statusColor = ShadowSyncColors.text;
        statusIcon = Icons.hourglass_empty;
        statusText = l10n.waiting;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacityFixed(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacityFixed(0.3)),
      ),
      child: Row(
        children: [
          result.overallStatus == DiskTestStatus.running
              ? SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: statusColor,
                  ),
                )
              : Icon(statusIcon, color: statusColor, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (result.totalDuration != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    l10n.totalTime(_formatDuration(result.totalDuration!)),
                    style: TextStyle(
                      color: ShadowSyncColors.text.withOpacityFixed(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestResult(DiskTestResult test, AppLocalizations l10n) {
    Color statusColor;
    IconData statusIcon;
    
    switch (test.status) {
      case DiskTestStatus.running:
        statusColor = ShadowSyncColors.accent;
        statusIcon = Icons.sync;
        break;
      case DiskTestStatus.passed:
        statusColor = ShadowSyncColors.success;
        statusIcon = Icons.check_circle;
        break;
      case DiskTestStatus.warning:
        statusColor = Colors.orange;
        statusIcon = Icons.warning_amber;
        break;
      case DiskTestStatus.failed:
        statusColor = Colors.red.shade400;
        statusIcon = Icons.error;
        break;
      case DiskTestStatus.skipped:
        statusColor = ShadowSyncColors.text.withOpacityFixed(0.5);
        statusIcon = Icons.skip_next;
        break;
      default:
        statusColor = ShadowSyncColors.text.withOpacityFixed(0.5);
        statusIcon = Icons.hourglass_empty;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ShadowSyncColors.primaryBackground.withOpacityFixed(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
      ),
      child: Row(
        children: [
          test.status == DiskTestStatus.running
              ? SizedBox(
                  width: kTestStatusIconSize,
                  height: kTestStatusIconSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: statusColor,
                  ),
                )
              : Icon(statusIcon, color: statusColor, size: kTestStatusIconSize),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  test.testName,
                  style: const TextStyle(
                    color: ShadowSyncColors.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (test.message != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    test.message!,
                    style: TextStyle(
                      color: ShadowSyncColors.text.withOpacityFixed(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (test.duration != null)
            Text(
              _formatDuration(test.duration!),
              style: TextStyle(
                color: ShadowSyncColors.text.withOpacityFixed(0.5),
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter({required double padding, required bool isMobile}) {
    final l10n = AppLocalizations.of(context);
    final showStartButton = _selectedDisk != null && !_isVerifying && 
        (_verificationResult == null || 
         _verificationResult!.overallStatus != DiskTestStatus.running);
    
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
        ),
      ),
      child: isMobile
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showStartButton)
                  ElevatedButton.icon(
                    onPressed: _startVerification,
                    icon: const Icon(Icons.play_arrow, size: 20),
                    label: Text(
                      _verificationResult == null ? l10n.startVerification : l10n.verifyAgain,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ShadowSyncColors.accent,
                      foregroundColor: ShadowSyncColors.text,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                if (showStartButton)
                  const SizedBox(height: 12),
                TextButton(
                  onPressed: _isVerifying ? null : () => Navigator.of(context).pop(),
                  child: Text(
                    l10n.close,
                    style: TextStyle(
                      color: _isVerifying 
                          ? ShadowSyncColors.text.withOpacityFixed(0.3)
                          : ShadowSyncColors.text.withOpacityFixed(0.7),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isVerifying ? null : () => Navigator.of(context).pop(),
                  child: Text(
                    l10n.close,
                    style: TextStyle(
                      color: _isVerifying 
                          ? ShadowSyncColors.text.withOpacityFixed(0.3)
                          : ShadowSyncColors.text.withOpacityFixed(0.7),
                    ),
                  ),
                ),
                if (showStartButton) ...[
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _startVerification,
                    icon: const Icon(Icons.play_arrow, size: 20),
                    label: Text(
                      _verificationResult == null ? l10n.startVerification : l10n.verifyAgain,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ShadowSyncColors.accent,
                      foregroundColor: ShadowSyncColors.text,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inSeconds < 1) {
      return '${duration.inMilliseconds}ms';
    } else if (duration.inMinutes < 1) {
      return '${duration.inSeconds}s';
    } else {
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    }
  }
}

// ============================================================================
// WIDGET ITEM DE DISCO
// ============================================================================

class _DiskListItem extends StatelessWidget {
  const _DiskListItem({
    required this.disk,
    required this.onTap,
  });

  final DiskInfo disk;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final usedPercentage = disk.usedPercentage;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(kDiskItemBorderRadius),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ShadowSyncColors.primaryBackground.withOpacityFixed(0.5),
            borderRadius: BorderRadius.circular(kDiskItemBorderRadius),
            border: Border.all(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
          ),
          child: Row(
            children: [
              // Ícone do disco
              Container(
                width: kDiskIconSize,
                height: kDiskIconSize,
                decoration: BoxDecoration(
                  color: ShadowSyncColors.accent.withOpacityFixed(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  disk.isRemovable ? Icons.usb : Icons.storage,
                  color: ShadowSyncColors.accent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              
              // Informações do disco
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            disk.name,
                            style: const TextStyle(
                              color: ShadowSyncColors.text,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (disk.mediaType != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: ShadowSyncColors.accent.withOpacityFixed(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              disk.mediaType!,
                              style: const TextStyle(
                                color: ShadowSyncColors.accent,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      disk.mountPoint,
                      style: TextStyle(
                        color: ShadowSyncColors.text.withOpacityFixed(0.5),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Barra de espaço em disco (padronizada para todos)
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (disk.totalSpace != null && disk.availableSpace != null)
                                  ? usedPercentage ?? 0
                                  : 0,
                              backgroundColor: ShadowSyncColors.border.withOpacityFixed(0.3),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                (usedPercentage != null && usedPercentage > 0.85)
                                    ? Colors.orange
                                    : ShadowSyncColors.accent,
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (disk.totalSpace != null && disk.availableSpace != null)
                          Text(
                            AppLocalizations.of(context).freeSpace(DiskInfo.formatBytes(disk.availableSpace)),
                            style: TextStyle(
                              color: ShadowSyncColors.text.withOpacityFixed(0.6),
                              fontSize: 11,
                            ),
                          )
                        else
                          Text(
                            AppLocalizations.of(context).diskSpaceUnavailable,
                            style: TextStyle(
                              color: ShadowSyncColors.text.withOpacityFixed(0.5),
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right,
                color: ShadowSyncColors.text,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET CARD DE INFORMAÇÕES DO DISCO
// ============================================================================

class _DiskInfoCard extends StatelessWidget {
  const _DiskInfoCard({required this.disk, required this.l10n});

  final DiskInfo disk;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ShadowSyncColors.primaryBackground.withOpacityFixed(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ShadowSyncColors.border.withOpacityFixed(0.3)),
      ),
      child: Column(
        children: [
          _buildInfoRow(l10n.mountPoint, disk.mountPoint),
          _buildInfoRow(l10n.device, disk.deviceIdentifier),
          if (disk.fileSystem != null)
            _buildInfoRow(l10n.fileSystem, disk.fileSystem!),
          if (disk.totalSpace != null)
            _buildInfoRow(l10n.totalCapacity, DiskInfo.formatBytes(disk.totalSpace)),
          if (disk.availableSpace != null)
            _buildInfoRow(l10n.availableSpaceLabel, DiskInfo.formatBytes(disk.availableSpace)),
          if (disk.mediaType != null)
            _buildInfoRow(l10n.mediaType, disk.mediaType!),
          _buildInfoRow(l10n.type, disk.isRemovable ? l10n.removable : l10n.internal),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              color: ShadowSyncColors.text.withOpacityFixed(0.6),
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: ShadowSyncColors.text,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
