import 'dart:async';

import 'backup_service.dart';
import 'disk_space_service.dart';

/// Serviço que monitora periodicamente o espaço disponível nos destinos.
class DiskMonitorService {
  DiskMonitorService(this._backupService, {DiskSpaceService? diskSpaceService})
      : _diskSpaceService = diskSpaceService ?? const DiskSpaceService();

  final BackupService _backupService;
  final DiskSpaceService _diskSpaceService;
  
  Timer? _timer;
  final _availableSpaceController = StreamController<Map<String, int?>>.broadcast();
  Map<String, int?> _availableSpaceCache = {};

  /// Stream que emite atualizações do espaço disponível por destino.
  /// Chave: caminho do destino, Valor: espaço disponível em bytes.
  Stream<Map<String, int?>> get availableSpaceStream => _availableSpaceController.stream;

  /// Cache atual do espaço disponível.
  Map<String, int?> get availableSpaceCache => Map.unmodifiable(_availableSpaceCache);

  /// Inicia o monitoramento periódico.
  /// [interval] define o intervalo entre verificações (padrão: 30 segundos).
  Future<void> start({Duration interval = const Duration(seconds: 30)}) async {
    await _updateAvailableSpace();
    
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) => _updateAvailableSpace());
  }

  /// Para o monitoramento.
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// Força uma atualização imediata.
  Future<void> refresh() async {
    await _updateAvailableSpace();
  }

  /// Obtém o espaço disponível para um destino específico (do cache).
  int? getAvailableSpace(String destinationPath) {
    return _availableSpaceCache[destinationPath];
  }

  Future<void> _updateAvailableSpace() async {
    try {
      final routines = await _backupService.listRoutines();
      final destinations = routines
          .map((r) => r.destinationPath)
          .where((path) => path.isNotEmpty)
          .toSet();

      final newCache = <String, int?>{};
      
      for (final destination in destinations) {
        try {
          final space = await _diskSpaceService.getAvailableSpace(destination);
          newCache[destination] = space;
        } catch (_) {
          newCache[destination] = null;
        }
      }

      _availableSpaceCache = newCache;
      _availableSpaceController.add(Map.unmodifiable(newCache));
    } catch (_) {
      // Ignora erros e mantém o cache anterior
    }
  }

  void dispose() {
    stop();
    _availableSpaceController.close();
  }
}
