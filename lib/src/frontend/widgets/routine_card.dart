// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// WIDGET: RoutineCard - Cartão de Exibição de Rotina de Backup
// DESCRIÇÃO: Widget que exibe as informações de uma rotina de backup, incluindo nome, status, progresso, espaço disponível e agendamento. O card é responsivo
// e se adapta a diferentes tamanhos de tela, oferecendo uma experiência otimizada tanto para desktop quanto para mobile.
// AUTOR: Eng. Hewerton Bianchi
// ============================================================================

// ============================================================================
// IMPORTAÇÕES
// ============================================================================
import 'dart:ui';
import 'package:flutter/material.dart';
import '../../backend/models/backup_routine.dart';
import '../../backend/services/disk_space_service.dart';
import '../../generated/l10n/app_localizations.dart';
import '../theme/shadowsync_theme.dart';

// ============================================================================
// CONFIGURAÇÃO DE TIPOGRAFIA DO CARD
// ============================================================================

/// Fonte padrão usada em todos os textos do card
const String kCardFontFamily = 'Roboto';

/// Peso da fonte para títulos
const FontWeight kCardTitleFontWeight = FontWeight.w600;

/// Peso da fonte para textos normais
const FontWeight kCardNormalFontWeight = FontWeight.normal;

/// Peso da fonte para textos com destaque médio
const FontWeight kCardMediumFontWeight = FontWeight.w500;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO DENSO (Mobile/Android)
// ============================================================================

/// Padding interno do card (modo denso)
const double kCardPaddingDense = 14.0;

/// Tamanho da fonte do título/nome da rotina (modo denso)
const double kCardTitleFontSizeDense = 16.0;

/// Tamanho da fonte do subtítulo/status (modo denso)
const double kCardSubtitleFontSizeDense = 13.0;

/// Tamanho da fonte das informações (disco, agenda) (modo denso)
const double kCardInfoFontSizeDense = 12.0;

/// Tamanho da fonte do percentual de progresso (modo denso)
const double kCardProgressFontSizeDense = 13.0;

/// Tamanho dos ícones principais (tipo, check, delete) (modo denso)
const double kCardMainIconSizeDense = 18.0;

/// Tamanho dos ícones de informação (disco, agenda) (modo denso)
const double kCardInfoIconSizeDense = 14.0;

/// Altura da barra de progresso (modo denso)
const double kCardProgressBarHeightDense = 5.0;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO NORMAL (Desktop)
// ============================================================================

/// Padding interno do card (modo normal)
const double kCardPaddingNormal = 14.0;

/// Tamanho da fonte do título/nome da rotina (modo normal)
const double kCardTitleFontSizeNormal = 16.0;

/// Tamanho da fonte do subtítulo/status (modo normal)
const double kCardSubtitleFontSizeNormal = 14.0;

/// Tamanho da fonte das informações (disco, agenda) (modo normal)
const double kCardInfoFontSizeNormal = 12.0;

/// Tamanho da fonte do percentual de progresso (modo normal)
const double kCardProgressFontSizeNormal = 14.0;

/// Tamanho dos ícones principais (tipo, check, delete) (modo normal)
const double kCardMainIconSizeNormal = 24.0;

/// Tamanho dos ícones de informação (disco, agenda) (modo normal)
const double kCardInfoIconSizeNormal = 16.0;

/// Altura da barra de progresso (modo normal)
const double kCardProgressBarHeightNormal = 8.0;

// ============================================================================
// CONFIGURAÇÃO DE ALTURA MÍNIMA DO CARD
// ============================================================================

/// Altura mínima do card (modo denso - Mobile/Android)
const double kCardMinHeightDense = 210.0;

/// Altura mínima do card (modo normal - Desktop)
const double kCardMinHeightNormal = 210.0;

/// Altura máxima do card (modo denso - Mobile/Android)
const double kCardMaxHeightDense = 230.0;

/// Altura máxima do card (modo normal - Desktop)
const double kCardMaxHeightNormal = 230.0;

// ============================================================================
// WIDGET ROUTINE CARD
// ============================================================================

class RoutineCard extends StatelessWidget {
  const RoutineCard({
    super.key,
    required this.routine,
    required this.isDense,
    required this.onDelete,
    this.availableSpace,
    this.onManualRun,
  });

  final BackupRoutine routine;
  final bool isDense;
  final VoidCallback onDelete;
  /// Espaço disponível no destino em bytes (atualizado em tempo real)
  final int? availableSpace;
  /// Callback para executar backup manual
  final VoidCallback? onManualRun;

  /// Verifica se é um backup manual
  bool get _isManual => routine.scheduleType == ScheduleType.manual;
  bool get _isRunning {
    return routine.progress > 0 && 
           routine.progress < 1.0 && 
           !routine.isCompleted &&
           !routine.status.toLowerCase().contains('falha');
  }

  /// Localiza o status substituindo textos hardcoded por versões traduzidas
  String _localizeStatus(BuildContext context, String status) {
    final l10n = AppLocalizations.of(context);
    
    // Substitui "Último backup:" pela versão localizada
    if (status.startsWith('Último backup: ')) {
      return status.replaceFirst('Último backup: ', l10n.lastBackupLabel);
    }
    
    return status;
  }

  @override
  Widget build(BuildContext context) {
    final isEncrypted = routine.type == BackupType.encrypted;
    final leadingIcon = isEncrypted ? Icons.lock : Icons.folder_copy_outlined;
    final leadingColor = isEncrypted
        ? ShadowSyncColors.success
        : ShadowSyncColors.accent;
    
    // Verifica se houve falha no backup
    final hasFailed = routine.status.toLowerCase().contains('falha');
    
    // Define a cor de fundo baseada no estado
    final cardBackgroundColor = hasFailed
        ? Colors.red.withOpacityFixed(0.15)
        : ShadowSyncColors.secondary.withOpacityFixed(0.55);
    
    // Define a cor da borda baseada no estado
    final cardBorderColor = hasFailed
        ? Colors.red.withOpacityFixed(0.4)
        : ShadowSyncColors.border;
    
    // Seleciona tamanhos baseado no modo
    final padding = isDense ? kCardPaddingDense : kCardPaddingNormal;
    final titleSize = isDense ? kCardTitleFontSizeDense : kCardTitleFontSizeNormal;
    final subtitleSize = isDense ? kCardSubtitleFontSizeDense : kCardSubtitleFontSizeNormal;
    final mainIconSize = isDense ? kCardMainIconSizeDense : kCardMainIconSizeNormal;
    final progressFontSize = isDense ? kCardProgressFontSizeDense : kCardProgressFontSizeNormal;
    final progressBarHeight = isDense ? kCardProgressBarHeightDense : kCardProgressBarHeightNormal;
    final minHeight = isDense ? kCardMinHeightDense : kCardMinHeightNormal;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cardBorderColor),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(leadingIcon, color: leadingColor, size: mainIconSize),
                    const Spacer(),
                    if (hasFailed)
                      Padding(
                        padding: EdgeInsets.only(right: isDense ? 4 : 6),
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                          size: mainIconSize,
                        ),
                      )
                    else if (routine.isCompleted)
                      Padding(
                        padding: EdgeInsets.only(right: isDense ? 4 : 6),
                        child: Icon(
                          Icons.check_circle,
                          color: ShadowSyncColors.success,
                          size: mainIconSize,
                        ),
                      ),
                    // Botão Play para backup manual
                    if (_isManual && !_isRunning && onManualRun != null)
                      Padding(
                        padding: EdgeInsets.only(right: isDense ? 4 : 6),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.play_circle_fill,
                            color: ShadowSyncColors.accent,
                            size: mainIconSize,
                          ),
                          tooltip: AppLocalizations.of(context).runBackup,
                          onPressed: onManualRun,
                        ),
                      ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.white70,
                        size: mainIconSize,
                      ),
                      tooltip: AppLocalizations.of(context).deleteRoutineTooltip,
                      onPressed: onDelete,
                    ),
                  ],
                ),
                SizedBox(height: isDense ? 4 : 10),
                Text(
                  routine.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: kCardFontFamily,
                    color: ShadowSyncColors.text,
                    fontSize: titleSize,
                    fontWeight: kCardTitleFontWeight,
                  ),
                ),
                SizedBox(height: isDense ? 2 : 3),
                // Status com animação de loading quando em execução
                Row(
                  children: [
                    if (_isRunning) ...[
                      SizedBox(
                        width: isDense ? 14 : 16,
                        height: isDense ? 14 : 16,
                        child: CircularProgressIndicator(
                          strokeWidth: isDense ? 2.0 : 2.5,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            ShadowSyncColors.accent,
                          ),
                        ),
                      ),
                      SizedBox(width: isDense ? 6 : 8),
                    ],
                    Expanded(
                      child: Text(
                        _localizeStatus(context, routine.status),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: kCardFontFamily,
                          color: _isRunning 
                              ? ShadowSyncColors.accent 
                              : ShadowSyncColors.text,
                          fontSize: subtitleSize,
                          fontWeight: _isRunning 
                              ? kCardMediumFontWeight 
                              : kCardNormalFontWeight,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isDense ? 4 : 6),
                _DiskInfoRow(
                  sourceSize: routine.sourceSize,
                  availableSpace: availableSpace,
                  isDense: isDense,
                ),
                SizedBox(height: isDense ? 4 : 6),
                _ScheduleInfoRow(
                  scheduleType: routine.scheduleType,
                  nextRunAt: routine.nextRunAt,
                  lastRunAt: routine.lastRunAt,
                  isDense: isDense,
                ),
                SizedBox(height: isDense ? 8 : 12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(99),
                        child: LinearProgressIndicator(
                          value: routine.progress,
                          minHeight: progressBarHeight,
                          backgroundColor: Colors.white10,
                          valueColor: const AlwaysStoppedAnimation(
                            ShadowSyncColors.accent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(routine.progress * 100).round()}%',
                      style: TextStyle(
                        fontFamily: kCardFontFamily,
                        color: _isRunning 
                            ? ShadowSyncColors.accent 
                            : ShadowSyncColors.text,
                        fontSize: progressFontSize,
                        fontWeight: kCardTitleFontWeight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}

class _DiskInfoRow extends StatelessWidget {
  const _DiskInfoRow({
    required this.sourceSize,
    required this.availableSpace,
    required this.isDense,
  });

  final int? sourceSize;
  final int? availableSpace;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    final fontSize = isDense ? kCardInfoFontSizeDense : kCardInfoFontSizeNormal;
    final iconSize = isDense ? kCardInfoIconSizeDense : kCardInfoIconSizeNormal;

    // Determina status de espaço
    final bool hasSpaceInfo = sourceSize != null && availableSpace != null;
    final bool hasEnoughSpace = hasSpaceInfo && availableSpace! >= sourceSize!;
    
    Color statusColor;
    IconData statusIcon;
    
    if (!hasSpaceInfo) {
      statusColor = Colors.white54;
      statusIcon = Icons.help_outline;
    } else if (hasEnoughSpace) {
      statusColor = ShadowSyncColors.success;
      statusIcon = Icons.check_circle_outline;
    } else {
      statusColor = Colors.redAccent;
      statusIcon = Icons.warning_amber_rounded;
    }

    return Row(
      children: [
        Icon(Icons.folder_zip_outlined, size: iconSize, color: Colors.white54),
        SizedBox(width: isDense ? 2 : 4),
        Text(
          sourceSize != null
              ? DiskSpaceService.formatBytes(sourceSize!)
              : '--',
          style: TextStyle(
            fontFamily: kCardFontFamily,
            color: Colors.white70,
            fontSize: fontSize,
          ),
        ),
        SizedBox(width: isDense ? 4 : 8),
        Icon(Icons.storage_outlined, size: iconSize, color: Colors.white54),
        SizedBox(width: isDense ? 2 : 4),
        Text(
          availableSpace != null
              ? DiskSpaceService.formatBytes(availableSpace!)
              : '--',
          style: TextStyle(
            fontFamily: kCardFontFamily,
            color: Colors.white70,
            fontSize: fontSize,
          ),
        ),
        SizedBox(width: isDense ? 4 : 6),
        Icon(statusIcon, size: iconSize, color: statusColor),
      ],
    );
  }
}

class _ScheduleInfoRow extends StatelessWidget {
  const _ScheduleInfoRow({
    required this.scheduleType,
    required this.nextRunAt,
    required this.lastRunAt,
    required this.isDense,
  });

  final ScheduleType scheduleType;
  final DateTime? nextRunAt;
  final DateTime? lastRunAt;
  final bool isDense;

  /// Retorna o texto de agendamento baseado no tipo
  String _getScheduleText(BuildContext context) {
    switch (scheduleType) {
      case ScheduleType.manual:
        return AppLocalizations.of(context).manualExecution;
      case ScheduleType.daily:
      case ScheduleType.weekly:
      case ScheduleType.interval:
        return nextRunAt != null ? _formatDateTime(nextRunAt!) : AppLocalizations.of(context).noScheduleAvailable;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = isDense ? kCardInfoFontSizeDense : kCardInfoFontSizeNormal;
    final iconSize = isDense ? kCardInfoIconSizeDense : kCardInfoIconSizeNormal;
    final isManual = scheduleType == ScheduleType.manual;
    final scheduleIcon = isManual ? Icons.touch_app_outlined : Icons.schedule_outlined;

    // No modo compacto, mostra apenas próximo backup em uma linha
    if (isDense) {
      return Row(
        children: [
          Icon(scheduleIcon, size: iconSize, color: ShadowSyncColors.accent),
          const SizedBox(width: 3),
          Expanded(
            child: Text(
              _getScheduleText(context),
              style: TextStyle(
                fontFamily: kCardFontFamily,
                color: ShadowSyncColors.accent,
                fontSize: fontSize,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (lastRunAt != null) ...[
            const SizedBox(width: 6),
            Icon(Icons.history_outlined, size: iconSize, color: Colors.white38),
            const SizedBox(width: 2),
            Text(
              _formatDateShort(lastRunAt!),
              style: TextStyle(
                fontFamily: kCardFontFamily,
                color: Colors.white54,
                fontSize: fontSize,
              ),
            ),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(scheduleIcon, size: iconSize, color: ShadowSyncColors.accent),
            const SizedBox(width: 4),
            Text(
              isManual ? AppLocalizations.of(context).mode : AppLocalizations.of(context).next,
              style: TextStyle(
                fontFamily: kCardFontFamily,
                color: Colors.white54,
                fontSize: fontSize,
              ),
            ),
            Expanded(
              child: Text(
                _getScheduleText(context),
                style: TextStyle(
                  fontFamily: kCardFontFamily,
                  color: ShadowSyncColors.accent,
                  fontSize: fontSize,
                  fontWeight: kCardMediumFontWeight,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (lastRunAt != null) ...[
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.history_outlined, size: iconSize, color: Colors.white54),
              const SizedBox(width: 4),
              Text(
                AppLocalizations.of(context).last,
                style: TextStyle(
                  fontFamily: kCardFontFamily,
                  color: Colors.white54,
                  fontSize: fontSize,
                ),
              ),
              Expanded(
                child: Text(
                  _formatDateTime(lastRunAt!),
                  style: TextStyle(
                    fontFamily: kCardFontFamily,
                    color: Colors.white70,
                    fontSize: fontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  String _formatDateShort(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    return '$day/$month';
  }

  String _formatDateTime(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day/$month/$year às $hour:$minute';
  }
}
