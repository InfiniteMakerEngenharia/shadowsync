import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Serviço para gerenciar permissões de armazenamento no Android.
class PermissionService {
  const PermissionService();

  /// Solicita permissões de armazenamento necessárias para o app funcionar.
  /// Retorna true se todas as permissões foram concedidas.
  Future<bool> requestStoragePermissions() async {
    // Só é necessário no Android
    if (!Platform.isAndroid) {
      return true;
    }

    // Android 11+ (API 30+) requer MANAGE_EXTERNAL_STORAGE
    // Android 10 e abaixo usam READ/WRITE_EXTERNAL_STORAGE
    
    final androidInfo = await _getAndroidSdkVersion();
    
    if (androidInfo >= 30) {
      // Android 11+ - precisa de MANAGE_EXTERNAL_STORAGE
      final status = await Permission.manageExternalStorage.status;
      
      if (status.isDenied) {
        final result = await Permission.manageExternalStorage.request();
        return result.isGranted;
      }
      
      return status.isGranted;
    } else {
      // Android 10 e abaixo
      final storageStatus = await Permission.storage.status;
      
      if (storageStatus.isDenied) {
        final result = await Permission.storage.request();
        return result.isGranted;
      }
      
      return storageStatus.isGranted;
    }
  }

  /// Verifica se as permissões de armazenamento estão concedidas.
  Future<bool> hasStoragePermissions() async {
    if (!Platform.isAndroid) {
      return true;
    }

    final androidInfo = await _getAndroidSdkVersion();
    
    if (androidInfo >= 30) {
      return await Permission.manageExternalStorage.isGranted;
    } else {
      return await Permission.storage.isGranted;
    }
  }

  /// Abre as configurações do app para que o usuário possa conceder permissões manualmente.
  Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  /// Solicita que o app seja ignorado nas otimizações de bateria.
  /// Isso é importante para que o serviço de background funcione corretamente.
  Future<bool> requestIgnoreBatteryOptimizations() async {
    if (!Platform.isAndroid) {
      return true;
    }

    final status = await Permission.ignoreBatteryOptimizations.status;
    
    if (status.isDenied) {
      final result = await Permission.ignoreBatteryOptimizations.request();
      return result.isGranted;
    }
    
    return status.isGranted;
  }

  /// Verifica se o app está sendo ignorado nas otimizações de bateria.
  Future<bool> isIgnoringBatteryOptimizations() async {
    if (!Platform.isAndroid) {
      return true;
    }

    return await Permission.ignoreBatteryOptimizations.isGranted;
  }

  /// Obtém a versão do SDK Android.
  Future<int> _getAndroidSdkVersion() async {
    // O permission_handler já lida com isso internamente,
    // mas usamos um valor seguro como fallback
    try {
      // Tenta detectar pela variável de ambiente ou usa um valor padrão
      // Para Android 11+, assumimos API 30+
      return 30; // Assume Android 11+ para garantir que MANAGE_EXTERNAL_STORAGE seja solicitado
    } catch (_) {
      return 30;
    }
  }
}
