import '../../backend/models/backup_routine.dart';
import '../../backend/services/backup_service.dart';
import '../../backend/services/disk_monitor_service.dart';

class DashboardController {
  DashboardController(this._service, {DiskMonitorService? diskMonitorService})
      : _diskMonitorService = diskMonitorService;

  final BackupService _service;
  final DiskMonitorService? _diskMonitorService;

  Future<List<BackupRoutine>> loadRoutines() {
    return _service.listRoutines();
  }

  Stream<List<BackupRoutine>> watchRoutines() {
    return _service.watchRoutines();
  }

  /// Obtém todas as rotinas atuais.
  Future<List<BackupRoutine>> getAllRoutines() {
    return _service.listRoutines();
  }

  /// Stream de atualizações do espaço disponível nos destinos.
  Stream<Map<String, int?>>? watchAvailableSpace() {
    return _diskMonitorService?.availableSpaceStream;
  }

  /// Obtém o espaço disponível atual para um destino específico.
  int? getAvailableSpace(String destinationPath) {
    return _diskMonitorService?.getAvailableSpace(destinationPath);
  }

  /// Cache atual de espaço disponível.
  Map<String, int?> get availableSpaceCache {
    return _diskMonitorService?.availableSpaceCache ?? {};
  }

  Future<void> createRoutine(BackupRoutine routine) {
    return _service.createRoutine(routine);
  }

  Future<void> deleteRoutine(String id) {
    return _service.deleteRoutine(id);
  }

  /// Executa um backup manualmente
  Future<BackupRoutine?> runRoutine(String id) {
    return _service.runRoutine(id);
  }

  /// Recarrega os dados do repositório (útil quando o app volta do background)
  Future<void> refresh() {
    return _service.reload();
  }
}
