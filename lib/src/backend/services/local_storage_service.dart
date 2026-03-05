import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  LocalStorageService._();

  static const String routinesBoxName = 'backup_routines_v1';

  /// Obtém a box atual (abre se necessário)
  Box<dynamic> get _routinesBox {
    if (!Hive.isBoxOpen(routinesBoxName)) {
      throw StateError('Box não está aberta. Chame create() primeiro.');
    }
    return Hive.box<dynamic>(routinesBoxName);
  }

  static Future<LocalStorageService> create() async {
    // Verifica se a box já está aberta (evita conflito entre isolates)
    if (Hive.isBoxOpen(routinesBoxName)) {
      return LocalStorageService._();
    }
    
    // Abre a box com compact para garantir dados atualizados
    await Hive.openBox<dynamic>(
      routinesBoxName,
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 5,
    );
    return LocalStorageService._();
  }

  bool get isRoutinesEmpty => _routinesBox.isEmpty;

  /// Recarrega os dados do disco (útil quando o app volta do background)
  Future<void> reload() async {
    // Fecha e reabre a box para pegar dados atualizados do disco
    if (Hive.isBoxOpen(routinesBoxName)) {
      final box = Hive.box<dynamic>(routinesBoxName);
      await box.close();
    }
    await Hive.openBox<dynamic>(
      routinesBoxName,
      compactionStrategy: (entries, deletedEntries) => deletedEntries > 5,
    );
  }

  List<Map<String, dynamic>> readRoutineMaps() {
    return _routinesBox.values
        .whereType<Map>()
        .map((entry) => Map<String, dynamic>.from(entry))
        .toList();
  }

  Future<void> putRoutineMap(String id, Map<String, dynamic> data) async {
    await _routinesBox.put(id, data);
    // Força a persistência no disco para garantir sincronização entre isolates
    await _routinesBox.flush();
  }

  Future<void> deleteRoutineMap(String id) async {
    await _routinesBox.delete(id);
    await _routinesBox.flush();
  }
}
