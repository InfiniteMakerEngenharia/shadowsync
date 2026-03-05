import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/user_settings.dart';

/// Serviço para gerenciar as configurações do usuário.
class UserSettingsService {
  UserSettingsService._();

  static UserSettingsService? _instance;
  static const String _boxName = 'user_settings';
  static const String _settingsKey = 'settings';

  Box<UserSettings>? _box;
  final _settingsController = StreamController<UserSettings>.broadcast();

  /// Obtém a instância singleton do serviço
  static Future<UserSettingsService> getInstance() async {
    if (_instance == null) {
      _instance = UserSettingsService._();
      await _instance!._init();
    }
    return _instance!;
  }

  Future<void> _init() async {
    // Adapter é registrado no main.dart
    _box = await Hive.openBox<UserSettings>(_boxName);
  }

  /// Obtém as configurações atuais
  UserSettings getSettings() {
    return _box?.get(_settingsKey) ?? UserSettings();
  }

  /// Stream para observar mudanças nas configurações
  Stream<UserSettings> watchSettings() {
    // Emite o valor atual primeiro
    Future.microtask(() => _settingsController.add(getSettings()));
    return _settingsController.stream;
  }

  /// Salva as configurações
  Future<void> saveSettings(UserSettings settings) async {
    await _box?.put(_settingsKey, settings);
    _settingsController.add(settings);
  }

  /// Atualiza campos específicos das configurações
  Future<void> updateSettings({
    String? userName,
    String? avatarPath,
    String? encryptionPassword,
    bool? useCustomBackupName,
    String? customBackupName,
  }) async {
    final current = getSettings();
    final updated = current.copyWith(
      userName: userName,
      avatarPath: avatarPath,
      encryptionPassword: encryptionPassword,
      useCustomBackupName: useCustomBackupName,
      customBackupName: customBackupName,
    );
    await saveSettings(updated);
  }

  /// Permite ao usuário escolher uma imagem para o avatar
  /// Retorna o caminho do arquivo copiado para o diretório do app, ou null se cancelado
  Future<String?> pickAndSaveAvatar() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result == null || result.files.isEmpty) {
        return null;
      }

      final pickedFile = result.files.first;
      if (pickedFile.path == null) {
        return null;
      }

      // Copia a imagem para um local persistente dentro do app
      final appDir = await _getAppDataDirectory();
      final avatarsDir = Directory(p.join(appDir, 'avatars'));
      if (!await avatarsDir.exists()) {
        await avatarsDir.create(recursive: true);
      }

      // Gera um nome único para o arquivo
      final extension = p.extension(pickedFile.path!);
      final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}$extension';
      final destinationPath = p.join(avatarsDir.path, fileName);

      // Copia o arquivo
      final sourceFile = File(pickedFile.path!);
      await sourceFile.copy(destinationPath);

      // Atualiza as configurações com o novo avatar
      await updateSettings(avatarPath: destinationPath);

      return destinationPath;
    } catch (e) {
      return null;
    }
  }

  /// Remove o avatar atual
  Future<void> removeAvatar() async {
    final current = getSettings();
    if (current.avatarPath != null) {
      try {
        final file = File(current.avatarPath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {
        // Ignora erros ao deletar
      }
    }
    await updateSettings(avatarPath: null);
  }

  /// Obtém o diretório de dados do aplicativo
  Future<String> _getAppDataDirectory() async {
    if (Platform.isAndroid || Platform.isIOS) {
      // Usa path_provider para obter o diretório correto em mobile
      final directory = await getApplicationDocumentsDirectory();
      return directory.path;
    } else if (Platform.isMacOS) {
      final home = Platform.environment['HOME'] ?? '';
      return p.join(home, 'Library', 'Application Support', 'ShadowSync');
    } else if (Platform.isWindows) {
      final appData = Platform.environment['APPDATA'] ?? '';
      return p.join(appData, 'ShadowSync');
    } else if (Platform.isLinux) {
      final home = Platform.environment['HOME'] ?? '';
      return p.join(home, '.local', 'share', 'shadowsync');
    }
    return '.';
  }

  /// Limpa todas as configurações
  Future<void> clearSettings() async {
    final current = getSettings();
    // Remove o avatar se existir
    if (current.avatarPath != null) {
      try {
        final file = File(current.avatarPath!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (_) {}
    }
    await _box?.clear();
    _settingsController.add(UserSettings());
  }

  /// Fecha o serviço
  Future<void> dispose() async {
    await _settingsController.close();
    await _box?.close();
    _instance = null;
  }
}
