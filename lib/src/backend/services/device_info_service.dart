import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

/// Serviço para obter informações do dispositivo de forma multiplataforma.
class DeviceInfoService {
  DeviceInfoService._();

  static DeviceInfoService? _instance;
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  String? _cachedDeviceName;

  /// Obtém a instância singleton do serviço
  static DeviceInfoService getInstance() {
    _instance ??= DeviceInfoService._();
    return _instance!;
  }

  /// Obtém o nome do dispositivo.
  /// Retorna o modelo/nome do dispositivo em todas as plataformas.
  Future<String> getDeviceName() async {
    if (_cachedDeviceName != null) {
      return _cachedDeviceName!;
    }

    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        // Tenta usar o nome definido pelo usuário (disponível em API 25+)
        // Se não disponível, usa marca + modelo (ex: "Xiaomi Redmi Note 12")
        final deviceName = androidInfo.name;
        if (deviceName.isNotEmpty && deviceName != 'unknown') {
          _cachedDeviceName = deviceName;
        } else {
          // Combina marca e modelo para um nome mais legível
          final brand = androidInfo.brand;
          final model = androidInfo.model;
          if (brand.isNotEmpty) {
            // Capitaliza a marca (ex: "xiaomi" -> "Xiaomi")
            final capitalizedBrand = brand[0].toUpperCase() + brand.substring(1).toLowerCase();
            _cachedDeviceName = '$capitalizedBrand $model';
          } else {
            _cachedDeviceName = model;
          }
        }
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        // Usa o nome definido pelo usuário (ex: "iPhone de João")
        _cachedDeviceName = iosInfo.name;
      } else if (Platform.isMacOS) {
        final macInfo = await _deviceInfo.macOsInfo;
        // Usa o nome do computador
        _cachedDeviceName = macInfo.computerName;
      } else if (Platform.isWindows) {
        final windowsInfo = await _deviceInfo.windowsInfo;
        // Usa o nome do computador
        _cachedDeviceName = windowsInfo.computerName;
      } else if (Platform.isLinux) {
        final linuxInfo = await _deviceInfo.linuxInfo;
        // Usa o hostname ou pretty name
        _cachedDeviceName = linuxInfo.prettyName.isNotEmpty 
            ? linuxInfo.prettyName 
            : Platform.localHostname;
      } else {
        _cachedDeviceName = Platform.localHostname;
      }
    } catch (_) {
      // Fallback para hostname do sistema
      _cachedDeviceName = Platform.localHostname;
    }

    // Garantir que nunca retorne vazio
    if (_cachedDeviceName == null || _cachedDeviceName!.isEmpty) {
      _cachedDeviceName = 'Dispositivo Desconhecido';
    }

    return _cachedDeviceName!;
  }
}
