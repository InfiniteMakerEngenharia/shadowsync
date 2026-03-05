import '../models/backup_routine.dart';
import '../repositories/backup_repository.dart';
import 'backup_engine_service.dart';
import 'compression_service.dart';
import 'encryption_service.dart';

class BackupService {
  BackupService(BackupRepository repository, {BackupEngineService? engine})
    : _repository = repository,
      _engine =
          engine ??
          BackupEngineService(
            repository: repository,
            compressionService: const CompressionService(),
            encryptionService: const EncryptionService(),
          );

  final BackupRepository _repository;
  final BackupEngineService _engine;

  Future<List<BackupRoutine>> listRoutines() {
    return _repository.listRoutines();
  }

  Stream<List<BackupRoutine>> watchRoutines() {
    return _repository.watchRoutines();
  }

  Future<BackupRoutine?> getRoutineById(String id) {
    return _repository.getRoutineById(id);
  }

  Future<void> createRoutine(BackupRoutine routine) {
    return _repository.createRoutine(routine);
  }

  Future<void> updateRoutine(BackupRoutine routine) {
    return _repository.updateRoutine(routine);
  }

  Future<void> deleteRoutine(String id) {
    return _repository.deleteRoutine(id);
  }

  Future<BackupRoutine?> runRoutine(String id) {
    return _engine.runRoutine(id);
  }

  /// Recarrega os dados do disco (útil quando o app volta do background)
  Future<void> reload() {
    return _repository.reload();
  }
}
