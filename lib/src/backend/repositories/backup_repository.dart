import '../models/backup_routine.dart';

abstract class BackupRepository {
  Future<List<BackupRoutine>> listRoutines();

  Stream<List<BackupRoutine>> watchRoutines();

  Future<BackupRoutine?> getRoutineById(String id);

  Future<void> createRoutine(BackupRoutine routine);

  Future<void> updateRoutine(BackupRoutine routine);

  Future<void> deleteRoutine(String id);

  /// Recarrega os dados do disco (útil quando o app volta do background)
  Future<void> reload();
}
