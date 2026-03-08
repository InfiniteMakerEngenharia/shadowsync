import 'dart:async';

import 'package:cron/cron.dart';

import '../models/backup_routine.dart';
import 'backup_service.dart';

class SchedulerService {
  SchedulerService(this._backupService);

  final BackupService _backupService;
  final Cron _cron = Cron();
  final Set<String> _runningRoutineIds = <String>{};
  final List<ScheduledTask> _scheduledTasks = <ScheduledTask>[];
  
  /// Debounce timer para evitar rebuilds excessivos
  Timer? _rebuildDebounceTimer;
  
  /// Armazena as últimas rotinas para comparação
  List<BackupRoutine>? _lastRoutines;

  StreamSubscription<List<BackupRoutine>>? _routinesSubscription;
  bool _started = false;

  Future<void> start() async {
    if (_started) {
      return;
    }
    _started = true;

    final routines = await _backupService.listRoutines();
    _rebuildSchedules(routines);

    _routinesSubscription = _backupService.watchRoutines().listen(
      _onRoutinesChanged,
      onError: (_) {},
    );
  }
  
  /// Chamado quando a lista de rotinas muda
  void _onRoutinesChanged(List<BackupRoutine> routines) {
    // Se houver backups em execução, adia o rebuild
    if (_runningRoutineIds.isNotEmpty) {
      return;
    }
    
    // Verifica se realmente precisa rebuildar (mudança estrutural)
    if (_lastRoutines != null && !_needsRebuild(routines)) {
      return;
    }
    
    // Debounce: evita rebuilds múltiplos em sequência rápida
    _rebuildDebounceTimer?.cancel();
    _rebuildDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_runningRoutineIds.isEmpty) {
        _rebuildSchedules(routines);
      }
    });
  }
  
  /// Verifica se precisa rebuildar os schedules
  bool _needsRebuild(List<BackupRoutine> newRoutines) {
    if (_lastRoutines == null) return true;
    if (_lastRoutines!.length != newRoutines.length) return true;
    
    for (var i = 0; i < newRoutines.length; i++) {
      final oldRoutine = _lastRoutines![i];
      final newRoutine = newRoutines[i];
      
      // Só rebuilda se scheduleType ou scheduleValue mudou
      if (oldRoutine.id != newRoutine.id ||
          oldRoutine.scheduleType != newRoutine.scheduleType ||
          oldRoutine.scheduleValue != newRoutine.scheduleValue) {
        return true;
      }
    }
    
    return false;
  }

  Future<void> dispose() async {
    _rebuildDebounceTimer?.cancel();
    await _routinesSubscription?.cancel();
    for (final task in _scheduledTasks) {
      task.cancel();
    }
    _scheduledTasks.clear();
    _cron.close();
    _started = false;
  }

  void _rebuildSchedules(List<BackupRoutine> routines) {
    _lastRoutines = routines;
    
    for (final task in _scheduledTasks) {
      task.cancel();
    }
    _scheduledTasks.clear();

    for (final routine in routines) {
      final expression = _buildCronExpression(routine);
      if (expression == null) {
        continue;
      }

      final task = _cron.schedule(
        Schedule.parse(expression),
        () => _runRoutineSafely(routine.id),
      );
      _scheduledTasks.add(task);
    }
  }

  String? _buildCronExpression(BackupRoutine routine) {
    switch (routine.scheduleType) {
      case ScheduleType.manual:
        return null;
      case ScheduleType.daily:
        final time = _resolveHourMinute(routine);
        return '${time.minute} ${time.hour} * * *';
      case ScheduleType.weekly:
        final time = _resolveHourMinute(routine);
        final weekday = _resolveWeekday(routine);
        return '${time.minute} ${time.hour} * * $weekday';
      case ScheduleType.interval:
        final minutes = _resolveIntervalMinutes(routine);
        return _buildIntervalCronExpression(minutes);
    }
    return null;
  }

  _TimeParts _resolveHourMinute(BackupRoutine routine) {
    if (routine.nextRunAt != null) {
      return _TimeParts(
        hour: routine.nextRunAt!.hour,
        minute: routine.nextRunAt!.minute,
      );
    }

    final match = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(
      routine.scheduleValue ?? '',
    );
    if (match != null) {
      final hour = int.tryParse(match.group(1)!);
      final minute = int.tryParse(match.group(2)!);
      if (hour != null && minute != null) {
        return _TimeParts(hour: hour.clamp(0, 23), minute: minute.clamp(0, 59));
      }
    }

    return const _TimeParts(hour: 20, minute: 0);
  }

  int _resolveWeekday(BackupRoutine routine) {
    final weekday = routine.nextRunAt?.weekday ?? DateTime.now().weekday;
    return weekday % 7;
  }

  int _resolveIntervalMinutes(BackupRoutine routine) {
    final raw = routine.scheduleValue ?? '';
    // Formato esperado: "interval:60" (onde 60 são os minutos)
    final match = RegExp(r'interval:(\d+)').firstMatch(raw);
    if (match != null) {
      final parsed = int.tryParse(match.group(1)!);
      if (parsed != null && parsed > 0) {
        return parsed;
      }
    }
    // Fallback: tenta extrair qualquer número
    final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
    final parsed = int.tryParse(digits);
    if (parsed == null || parsed <= 0) {
      return 60; // Default: 1 hora
    }
    return parsed;
  }

  /// Constrói a expressão cron para intervalos de backup
  String _buildIntervalCronExpression(int minutes) {
    if (minutes < 60) {
      // Intervalo em minutos: */5 * * * *
      return '*/$minutes * * * *';
    } else if (minutes < 1440) {
      // Intervalo em horas: 0 */2 * * *
      final hours = minutes ~/ 60;
      return '0 */$hours * * *';
    } else {
      // Intervalo em dias: 0 0 */1 * *
      final days = minutes ~/ 1440;
      return '0 0 */$days * *';
    }
  }

  Future<void> _runRoutineSafely(String routineId) async {
    if (_runningRoutineIds.contains(routineId)) {
      return;
    }

    _runningRoutineIds.add(routineId);
    try {
      await _backupService.runRoutine(routineId);
    } finally {
      _runningRoutineIds.remove(routineId);
    }
  }
}

class _TimeParts {
  const _TimeParts({required this.hour, required this.minute});

  final int hour;
  final int minute;
}
