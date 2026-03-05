import 'backup_execution_config.dart';

enum BackupType { encrypted, standard }

enum ScheduleType { manual, daily, weekly, interval }

class BackupRoutine {
  const BackupRoutine({
    required this.id,
    required this.name,
    required this.sourcePaths,
    required this.destinationPath,
    required this.scheduleType,
    required this.status,
    required this.progress,
    required this.type,
    required this.isCompleted,
    required this.executionConfig,
    this.scheduleValue,
    this.lastRunAt,
    this.nextRunAt,
    this.sourceSize,
  });

  final String id;
  final String name;
  final List<String> sourcePaths;
  final String destinationPath;
  final ScheduleType scheduleType;
  final String? scheduleValue;
  final String status;
  final double progress;
  final BackupType type;
  final bool isCompleted;
  final BackupExecutionConfig executionConfig;
  final DateTime? lastRunAt;
  final DateTime? nextRunAt;
  /// Tamanho total das origens em bytes (calculado na criação)
  final int? sourceSize;

  BackupRoutine copyWith({
    String? id,
    String? name,
    List<String>? sourcePaths,
    String? destinationPath,
    ScheduleType? scheduleType,
    String? scheduleValue,
    String? status,
    double? progress,
    BackupType? type,
    bool? isCompleted,
    BackupExecutionConfig? executionConfig,
    DateTime? lastRunAt,
    DateTime? nextRunAt,
    int? sourceSize,
  }) {
    return BackupRoutine(
      id: id ?? this.id,
      name: name ?? this.name,
      sourcePaths: sourcePaths ?? this.sourcePaths,
      destinationPath: destinationPath ?? this.destinationPath,
      scheduleType: scheduleType ?? this.scheduleType,
      scheduleValue: scheduleValue ?? this.scheduleValue,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      executionConfig: executionConfig ?? this.executionConfig,
      lastRunAt: lastRunAt ?? this.lastRunAt,
      nextRunAt: nextRunAt ?? this.nextRunAt,
      sourceSize: sourceSize ?? this.sourceSize,
    );
  }
}
