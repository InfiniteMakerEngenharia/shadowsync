
// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Widget do footer de status do dashboard, exibindo o status do serviço em segundo plano e um botão para criar nova rotina de backup. 
// ============================================================================ 

// ============================================================================
// IMPORTAÇÕES
// ============================================================================
import 'package:flutter/material.dart';
import '../../backend/models/backup_routine.dart';
import '../../generated/l10n/app_localizations.dart';
import '../theme/shadowsync_theme.dart';

// ============================================================================
// CONFIGURAÇÃO DE TIPOGRAFIA DO STATUS FOOTER
// ============================================================================

/// Fonte padrão usada em todos os textos do footer
const String kFooterFontFamily = 'Roboto';

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO COMPACTO PORTRAIT (Celular vertical)
// ============================================================================

/// Tamanho da fonte do texto de status (portrait)
const double kFooterStatusFontSizePortrait = 13.0;

/// Espaçamento entre status e botão (portrait)
const double kFooterSpacingPortrait = 8.0;

/// Altura do botão (portrait)
const double kFooterButtonHeightPortrait = 40.0;

// ============================================================================
// CONFIGURAÇÃO DE TAMANHOS - MODO COMPACTO LANDSCAPE (Celular horizontal)
// ============================================================================

/// Tamanho da fonte do texto de status (landscape compacto)
const double kFooterStatusFontSizeLandscape = 14.0;

/// Espaçamento entre status e botão (landscape compacto)
const double kFooterSpacingLandscape = 10.0;

// ============================================================================
// CONFIGURAÇÃO DO INDICADOR DE STATUS
// ============================================================================

/// Tamanho do indicador de status (círculo verde)
const double kFooterIndicatorSize = 10.0;

/// Espaçamento entre o indicador e o texto
const double kFooterIndicatorSpacing = 10.0;

// ============================================================================
// CONFIGURAÇÃO DO BOTÃO
// ============================================================================

/// Tamanho do ícone do botão
const double kFooterButtonIconSize = 18.0;

/// Raio de borda do botão
const double kFooterButtonBorderRadius = 12.0;

// ============================================================================
// WIDGET STATUS FOOTER
// ============================================================================

class StatusFooter extends StatelessWidget {
  const StatusFooter({
    super.key,
    required this.isCompact,
    required this.isPhonePortrait,
    required this.onNewBackupPressed,
    required this.routines,
  });

  final bool isCompact;
  final bool isPhonePortrait;
  final VoidCallback onNewBackupPressed;
  final List<BackupRoutine> routines;

  /// Calcula o próximo backup agendado a partir das rotinas
  ({String name, DateTime time})? _getNextScheduledBackup() {
    DateTime? nextTime;
    String? nextName;
    final now = DateTime.now();

    for (final routine in routines) {
      if (routine.scheduleType == ScheduleType.manual) {
        continue;
      }

      final calculatedNext = _calculateNextRun(routine, now);
      if (calculatedNext != null) {
        if (nextTime == null || calculatedNext.isBefore(nextTime)) {
          nextTime = calculatedNext;
          nextName = routine.name;
        }
      }
    }

    if (nextTime != null && nextName != null) {
      return (name: nextName, time: nextTime);
    }
    return null;
  }

  /// Calcula a próxima execução de uma rotina
  DateTime? _calculateNextRun(BackupRoutine routine, DateTime now) {
    switch (routine.scheduleType) {
      case ScheduleType.manual:
        return null;

      case ScheduleType.daily:
        final time = _parseTime(routine.scheduleValue);
        if (time == null) return null;
        var next = DateTime(now.year, now.month, now.day, time.hour, time.minute);
        if (next.isBefore(now) || next.isAtSameMomentAs(now)) {
          next = next.add(const Duration(days: 1));
        }
        return next;

      case ScheduleType.weekly:
        final time = _parseTime(routine.scheduleValue);
        if (time == null) return null;
        final targetWeekday = routine.nextRunAt?.weekday ?? now.weekday;
        var next = DateTime(now.year, now.month, now.day, time.hour, time.minute);
        // Ajusta para o dia da semana correto
        final daysUntilTarget = (targetWeekday - now.weekday + 7) % 7;
        next = next.add(Duration(days: daysUntilTarget));
        if (next.isBefore(now) || next.isAtSameMomentAs(now)) {
          next = next.add(const Duration(days: 7));
        }
        return next;

      case ScheduleType.interval:
        final minutes = _parseIntervalMinutes(routine.scheduleValue);
        if (minutes == null || minutes <= 0) return null;
        // Calcula próximo intervalo a partir de agora
        final nextMinute = ((now.minute ~/ minutes) + 1) * minutes;
        if (nextMinute >= 60) {
          return DateTime(now.year, now.month, now.day, now.hour + 1, nextMinute % 60);
        }
        return DateTime(now.year, now.month, now.day, now.hour, nextMinute);
    }
  }

  /// Extrai hora e minuto de uma string no formato "HH:mm"
  ({int hour, int minute})? _parseTime(String? value) {
    if (value == null) return null;
    final match = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(value);
    if (match == null) return null;
    final hour = int.tryParse(match.group(1)!);
    final minute = int.tryParse(match.group(2)!);
    if (hour == null || minute == null) return null;
    return (hour: hour.clamp(0, 23), minute: minute.clamp(0, 59));
  }

  /// Extrai minutos de intervalo de uma string
  int? _parseIntervalMinutes(String? value) {
    if (value == null) return null;
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(digits);
  }

  /// Formata o horário para exibição
  String _formatTime(DateTime time, BuildContext context) {
    final now = DateTime.now();
    final isToday = time.year == now.year && time.month == now.month && time.day == now.day;
    final isTomorrow = time.year == now.year && time.month == now.month && time.day == now.day + 1;
    
    final timeStr = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    final l10n = AppLocalizations.of(context);
    
    if (isToday) {
      return '${l10n.dateToday}, $timeStr';
    } else if (isTomorrow) {
      return '${l10n.dateTomorrow}, $timeStr';
    } else {
      final weekdays = [
        l10n.weekdayMonday,
        l10n.weekdayTuesday,
        l10n.weekdayWednesday,
        l10n.weekdayThursday,
        l10n.weekdayFriday,
        l10n.weekdaySaturday,
        l10n.weekdaySunday,
      ];
      final weekday = weekdays[time.weekday - 1];
      return '$weekday, $timeStr';
    }
  }

  /// Gera a mensagem de status
  String _buildStatusMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if (routines.isEmpty) {
      return l10n.noRoutinesConfigured;
    }

    final hasScheduled = routines.any((r) => r.scheduleType != ScheduleType.manual);
    if (!hasScheduled) {
      return l10n.noScheduledBackups;
    }

    final next = _getNextScheduledBackup();
    if (next == null) {
      return l10n.serviceActive;
    }

    return '${l10n.next}"${next.name}" ${_formatTime(next.time, context)}';
  }

  @override
  Widget build(BuildContext context) {
    final statusFontSize = isPhonePortrait
        ? kFooterStatusFontSizePortrait
        : kFooterStatusFontSizeLandscape;
    final spacing = isPhonePortrait
        ? kFooterSpacingPortrait
        : kFooterSpacingLandscape;

    final statusMessage = _buildStatusMessage(context);
    final hasScheduledBackups = routines.any((r) => r.scheduleType != ScheduleType.manual);

    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _StatusIndicator(isActive: hasScheduledBackups),
              const SizedBox(width: kFooterIndicatorSpacing),
              Expanded(
                child: Text(
                  statusMessage,
                  style: TextStyle(
                    fontFamily: kFooterFontFamily,
                    color: ShadowSyncColors.text,
                    fontSize: statusFontSize,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: spacing),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: isPhonePortrait ? kFooterButtonHeightPortrait : null,
              child: _NewBackupButton(onPressed: onNewBackupPressed),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        _StatusIndicator(isActive: hasScheduledBackups),
        const SizedBox(width: kFooterIndicatorSpacing),
        Expanded(
          child: Text(
            statusMessage,
            style: TextStyle(
              fontFamily: kFooterFontFamily,
              color: ShadowSyncColors.text,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _NewBackupButton(onPressed: onNewBackupPressed),
      ],
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kFooterIndicatorSize,
      height: kFooterIndicatorSize,
      decoration: BoxDecoration(
        color: isActive ? ShadowSyncColors.success : ShadowSyncColors.text.withOpacityFixed(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _NewBackupButton extends StatelessWidget {
  const _NewBackupButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add, size: kFooterButtonIconSize),
      label: Text(AppLocalizations.of(context).newBackup),
      style: OutlinedButton.styleFrom(
        foregroundColor: ShadowSyncColors.text,
        side: const BorderSide(color: ShadowSyncColors.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kFooterButtonBorderRadius),
        ),
      ),
    );
  }
}
