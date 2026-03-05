import 'dart:async';

import '../models/backup_routine.dart';
import 'backup_repository.dart';

class InMemoryBackupRepository implements BackupRepository {
  InMemoryBackupRepository() : _routines = [];

  final List<BackupRoutine> _routines;
  final StreamController<List<BackupRoutine>> _changesController =
      StreamController<List<BackupRoutine>>.broadcast();

  @override
  Future<List<BackupRoutine>> listRoutines() async {
    return _snapshot();
  }

  @override
  Stream<List<BackupRoutine>> watchRoutines() async* {
    yield _snapshot();
    yield* _changesController.stream;
  }

  @override
  Future<BackupRoutine?> getRoutineById(String id) async {
    try {
      return _routines.firstWhere((routine) => routine.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> createRoutine(BackupRoutine routine) async {
    _routines.add(routine);
    _emitChanges();
  }

  @override
  Future<void> updateRoutine(BackupRoutine routine) async {
    final index = _routines.indexWhere((item) => item.id == routine.id);
    if (index < 0) {
      throw StateError('Rotina não encontrada: ${routine.id}');
    }

    _routines[index] = routine;
    _emitChanges();
  }

  @override
  Future<void> deleteRoutine(String id) async {
    _routines.removeWhere((routine) => routine.id == id);
    _emitChanges();
  }

  @override
  Future<void> reload() async {
    // InMemoryBackupRepository não tem persistência, então reload não faz nada
  }

  List<BackupRoutine> _snapshot() {
    return List<BackupRoutine>.unmodifiable(_routines);
  }

  void _emitChanges() {
    _changesController.add(_snapshot());
  }
}
