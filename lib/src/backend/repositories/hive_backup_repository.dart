import 'dart:async';

import '../models/backup_execution_config.dart';
import '../models/backup_routine.dart';
import '../services/local_storage_service.dart';
import 'backup_repository.dart';

class HiveBackupRepository implements BackupRepository {
  HiveBackupRepository(this._storage, {required List<BackupRoutine> seedData})
    : _seedData = seedData;

  final LocalStorageService _storage;
  final List<BackupRoutine> _seedData;
  final StreamController<List<BackupRoutine>> _changesController =
      StreamController<List<BackupRoutine>>.broadcast();

  final List<BackupRoutine> _routines = [];
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) {
      return;
    }

    if (_storage.isRoutinesEmpty) {
      for (final routine in _seedData) {
        await _storage.putRoutineMap(routine.id, _toMap(routine));
      }
    }

    final rawEntries = _storage.readRoutineMaps();
    _routines
      ..clear()
      ..addAll(rawEntries.map(_fromMap));

    _initialized = true;
  }

  @override
  Future<List<BackupRoutine>> listRoutines() async {
    await _ensureInitialized();
    return _snapshot();
  }

  @override
  Stream<List<BackupRoutine>> watchRoutines() async* {
    await _ensureInitialized();
    yield _snapshot();
    yield* _changesController.stream;
  }

  @override
  Future<BackupRoutine?> getRoutineById(String id) async {
    await _ensureInitialized();

    try {
      return _routines.firstWhere((routine) => routine.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> createRoutine(BackupRoutine routine) async {
    await _ensureInitialized();
    _routines.add(routine);
    await _storage.putRoutineMap(routine.id, _toMap(routine));
    _emitChanges();
  }

  @override
  Future<void> updateRoutine(BackupRoutine routine) async {
    await _ensureInitialized();
    final index = _routines.indexWhere((item) => item.id == routine.id);
    if (index < 0) {
      throw StateError('Rotina não encontrada: ${routine.id}');
    }

    _routines[index] = routine;
    await _storage.putRoutineMap(routine.id, _toMap(routine));
    _emitChanges();
  }

  @override
  Future<void> deleteRoutine(String id) async {
    await _ensureInitialized();
    _routines.removeWhere((routine) => routine.id == id);
    await _storage.deleteRoutineMap(id);
    _emitChanges();
  }

  @override
  Future<void> reload() async {
    // Força recarregamento dos dados do disco
    _initialized = false;
    _routines.clear();
    
    // Recarrega a box do disco
    await _storage.reload();
    
    // Reinicializa
    await _ensureInitialized();
    
    // Notifica listeners sobre a mudança
    _emitChanges();
  }

  void _emitChanges() {
    _changesController.add(_snapshot());
  }

  List<BackupRoutine> _snapshot() {
    return List<BackupRoutine>.unmodifiable(_routines);
  }

  Map<String, dynamic> _toMap(BackupRoutine routine) {
    return {
      'id': routine.id,
      'name': routine.name,
      'sourcePaths': routine.sourcePaths,
      'destinationPath': routine.destinationPath,
      'scheduleType': routine.scheduleType.name,
      'scheduleValue': routine.scheduleValue,
      'status': routine.status,
      'progress': routine.progress,
      'type': routine.type.name,
      'isCompleted': routine.isCompleted,
      'lastRunAt': routine.lastRunAt?.toIso8601String(),
      'nextRunAt': routine.nextRunAt?.toIso8601String(),
      'sourceSize': routine.sourceSize,
      'executionConfig': {
        'compressionEnabled': routine.executionConfig.compressionEnabled,
        'compressionFormat': routine.executionConfig.compressionFormat.name,
        'encryptionEnabled': routine.executionConfig.encryptionEnabled,
        'encryptionKeyRef': routine.executionConfig.encryptionKeyRef,
        'retentionCount': routine.executionConfig.retentionCount,
        'useCustomBackupName': routine.executionConfig.useCustomBackupName,
        'customBackupName': routine.executionConfig.customBackupName,
      },
    };
  }

  BackupRoutine _fromMap(Map<String, dynamic> map) {
    final configMap = Map<String, dynamic>.from(
      (map['executionConfig'] as Map?) ?? <String, dynamic>{},
    );

    return BackupRoutine(
      id: map['id'] as String,
      name: (map['name'] as String?) ?? 'Rotina sem nome',
      sourcePaths: ((map['sourcePaths'] as List?) ?? const <dynamic>[])
          .map((item) => item.toString())
          .toList(),
      destinationPath: (map['destinationPath'] as String?) ?? '',
      scheduleType: ScheduleType.values.byName(
        (map['scheduleType'] as String?) ?? ScheduleType.manual.name,
      ),
      scheduleValue: map['scheduleValue'] as String?,
      status: (map['status'] as String?) ?? 'Sem status',
      progress: ((map['progress'] as num?) ?? 0).toDouble(),
      type: BackupType.values.byName(
        (map['type'] as String?) ?? BackupType.standard.name,
      ),
      isCompleted: (map['isCompleted'] as bool?) ?? false,
      executionConfig: BackupExecutionConfig(
        compressionEnabled: (configMap['compressionEnabled'] as bool?) ?? false,
        compressionFormat: CompressionFormat.values.byName(
          (configMap['compressionFormat'] as String?) ??
              CompressionFormat.zip.name,
        ),
        encryptionEnabled: (configMap['encryptionEnabled'] as bool?) ?? false,
        encryptionKeyRef: configMap['encryptionKeyRef'] as String?,
        retentionCount: (configMap['retentionCount'] as num?)?.toInt(),
        useCustomBackupName: (configMap['useCustomBackupName'] as bool?) ?? false,
        customBackupName: configMap['customBackupName'] as String?,
      ),
      lastRunAt: _parseDate(map['lastRunAt'] as String?),
      nextRunAt: _parseDate(map['nextRunAt'] as String?),
      sourceSize: (map['sourceSize'] as num?)?.toInt(),
    );
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }
}
