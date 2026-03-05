// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Serviço responsável por verificar a integridade e saúde dos discos.
// ============================================================================

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../generated/l10n/app_localizations.dart';
import '../models/disk_info.dart';

// ============================================================================
// TIPOS DE TESTE
// ============================================================================

/// Tipos de testes de verificação de disco disponíveis.
enum DiskVerificationTest {
  /// Verifica acessibilidade e permissões do disco
  accessibility,
  /// Analisa espaço disponível e uso do disco
  spaceAnalysis,
  /// Teste de leitura sequencial para verificar consistência
  readTest,
  /// Verificação do sistema de arquivos
  fileSystemCheck,
  /// Leitura de informações S.M.A.R.T. (se disponível)
  smartStatus,
}

// ============================================================================
// SERVIÇO DE VERIFICAÇÃO DE DISCO
// ============================================================================

/// Serviço responsável por verificar a integridade e saúde dos discos.
/// 
/// Funcionalidades:
/// - Lista discos/volumes disponíveis no sistema
/// - Executa testes de verificação de integridade
/// - Reporta progresso e resultados dos testes
class DiskVerificationService {
  DiskVerificationService._({AppLocalizations? localizations})
      : _localizations = localizations;

  static DiskVerificationService? _instance;
  final AppLocalizations? _localizations;

  /// Obtém a instância singleton do serviço.
  static DiskVerificationService getInstance(
      {AppLocalizations? localizations}) {
    // Se localizations mudar, atualiza a instância
    if (_instance == null) {
      _instance = DiskVerificationService._(localizations: localizations);
    } else if (localizations != null) {
      _instance!._setLocalizations(localizations);
    }
    return _instance!;
  }

  /// Define as localizações para uso nos nomes dos discos
  void _setLocalizations(AppLocalizations localizations) {
    // Recria a instância com as novas localizações
    _instance = DiskVerificationService._(localizations: localizations);
  }

  // ==========================================================================
  // MÉTODO AUXILIAR PARA NOMES LOCALIZADOS
  // ==========================================================================

  /// Obtém o nome localizado para um tipo de armazenamento
  String _getLocalizedStorageName(String key) {
    if (_localizations == null) {
      // Fallback para português (padrão)
      final fallbacks = {
        'internalStorage': 'Armazenamento Interno',
        'sdCard': 'Cartão SD',
        'externalSdCard': 'Cartão SD Externo',
        'primaryStorage': 'Armazenamento Principal',
        'externalStorage': 'Armazenamento Externo',
        'deviceStorage': 'Armazenamento do Dispositivo',
        'appStorage': 'Armazenamento do App',
      };
      return fallbacks[key] ?? key;
    }

    return switch (key) {
      'internalStorage' => _localizations.internalStorage,
      'sdCard' => _localizations.sdCard,
      'externalSdCard' => _localizations.externalSdCard,
      'primaryStorage' => _localizations.primaryStorage,
      'externalStorage' => _localizations.externalStorage,
      'deviceStorage' => _localizations.deviceStorage,
      'appStorage' => _localizations.appStorage,
      _ => key,
    };
  }

  /// Obtém o nome localizado para um tipo de teste
  String _getLocalizedTestName(DiskVerificationTest test) {
    if (_localizations == null) {
      // Fallback para português (padrão)
      final fallbacks = {
        DiskVerificationTest.accessibility: 'Verificação de Acessibilidade',
        DiskVerificationTest.spaceAnalysis: 'Análise de Espaço em Disco',
        DiskVerificationTest.readTest: 'Teste de Leitura',
        DiskVerificationTest.fileSystemCheck: 'Verificação do Sistema de Arquivos',
        DiskVerificationTest.smartStatus: 'Status S.M.A.R.T.',
      };
      return fallbacks[test] ?? test.name;
    }

    return switch (test) {
      DiskVerificationTest.accessibility => _localizations.testAccessibilityCheck,
      DiskVerificationTest.spaceAnalysis => _localizations.testSpaceAnalysis,
      DiskVerificationTest.readTest => _localizations.testReadTest,
      DiskVerificationTest.fileSystemCheck => _localizations.testFileSystemCheck,
      DiskVerificationTest.smartStatus => _localizations.testSmartStatus,
    };
  }

  // ==========================================================================
  // LISTAGEM DE DISCOS
  // ==========================================================================

  /// Lista todos os discos/volumes disponíveis no sistema.
  Future<List<DiskInfo>> listDisks() async {
    try {
      if (Platform.isMacOS) {
        return await _listDisksMacOS();
      } else if (Platform.isLinux) {
        return await _listDisksLinux();
      } else if (Platform.isWindows) {
        return await _listDisksWindows();
      } else if (Platform.isAndroid) {
        return await _listDisksAndroid();
      } else if (Platform.isIOS) {
        return await _listDisksIOS();
      }
      return [];
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao listar discos: $e');
      return [];
    }
  }

  /// Lista discos no macOS usando diskutil.
  Future<List<DiskInfo>> _listDisksMacOS() async {
    final disks = <DiskInfo>[];
    final seenDeviceIds = <String>{};

    try {
      // Usa diskutil para listar volumes montados
      final result = await Process.run('diskutil', ['list', '-plist']);
      if (result.exitCode != 0) {
        debugPrint('[DiskVerificationService] Erro ao executar diskutil list');
        return disks;
      }

      // Primeiro, adiciona o volume raiz (/) para garantir que ele seja priorizado
      final rootInfo = await _getDiskInfoMacOS('/');
      if (rootInfo != null) {
        disks.add(rootInfo);
        seenDeviceIds.add(rootInfo.deviceIdentifier);
      }

      // Lista os volumes em /Volumes, evitando duplicatas pelo deviceIdentifier
      final volumesDir = Directory('/Volumes');
      if (await volumesDir.exists()) {
        await for (final entity in volumesDir.list()) {
          if (entity is Directory) {
            final info = await _getDiskInfoMacOS(entity.path);
            if (info != null && !seenDeviceIds.contains(info.deviceIdentifier)) {
              disks.add(info);
              seenDeviceIds.add(info.deviceIdentifier);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao listar discos macOS: $e');
    }

    return disks;
  }

  /// Obtém informações detalhadas de um disco no macOS.
  Future<DiskInfo?> _getDiskInfoMacOS(String mountPoint) async {
    try {
      final result = await Process.run('diskutil', ['info', mountPoint]);
      if (result.exitCode != 0) return null;

      final output = result.stdout as String;
      final lines = output.split('\n');

      String? name;
      String? deviceId;
      String? fileSystem;
      int? totalSpace;
      int? availableSpace;
      bool isRemovable = false;
      bool isInternal = true;
      String? mediaType;

      for (final line in lines) {
        final parts = line.split(':');
        if (parts.length < 2) continue;

        final key = parts[0].trim();
        final value = parts.sublist(1).join(':').trim();

        switch (key) {
          case 'Volume Name':
            name = value.isNotEmpty ? value : null;
            break;
          case 'Device Identifier':
            deviceId = value;
            break;
          case 'Type (Bundle)':
          case 'File System Personality':
            fileSystem ??= value;
            break;
          case 'Container Total Space':
          case 'Total Size':
          case 'Volume Total Space':
            // Tenta múltiplos padrões para extrair bytes
            var match = RegExp(r'\((\d+)\s+Bytes\)').firstMatch(value) ?? 
                        RegExp(r'(\d+)\s+Bytes').firstMatch(value);
            if (match != null) {
              totalSpace = int.tryParse(match.group(1)!);
            }
            break;
          case 'Container Free Space':
          case 'Volume Free Space':
          case 'Free Space':
            // Tenta múltiplos padrões para extrair bytes
            var match = RegExp(r'\((\d+)\s+Bytes\)').firstMatch(value) ?? 
                        RegExp(r'(\d+)\s+Bytes').firstMatch(value);
            if (match != null) {
              availableSpace = int.tryParse(match.group(1)!);
            }
            break;
          case 'Removable Media':
            isRemovable = value.toLowerCase() == 'yes' || value.toLowerCase() == 'removable';
            break;
          case 'Device Location':
            isInternal = value.toLowerCase().contains('internal');
            break;
          case 'Solid State':
            mediaType = value.toLowerCase() == 'yes' ? 'SSD' : 'HDD';
            break;
        }
      }

      // Se as informações de espaço ainda não foram obtidas via diskutil,
      // tenta usar 'df' que funciona melhor para discos removíveis
      if ((totalSpace == null || availableSpace == null) && mountPoint.isNotEmpty) {
        try {
          final dfResult = await Process.run('df', ['-b', mountPoint]);
          if (dfResult.exitCode == 0) {
            final dfOutput = dfResult.stdout as String;
            final dfLines = dfOutput.split('\n');
            if (dfLines.length > 1) {
              // Formato: Filesystem 1024-blocks Used Available Use% Mounted on
              final parts = dfLines[1].split(RegExp(r'\s+'));
              if (parts.length >= 3) {
                // Converte de blocos para bytes (blocos de 512 bytes no macOS)
                totalSpace ??= int.tryParse(parts[1]) != null 
                    ? (int.parse(parts[1]) * 512) 
                    : null;
                availableSpace ??= int.tryParse(parts[3]) != null 
                    ? (int.parse(parts[3]) * 512) 
                    : null;
              }
            }
          }
        } catch (e) {
          debugPrint('[DiskVerificationService] Erro ao usar df: $e');
        }
      }

      if (deviceId == null) return null;

      // Usa o nome do mount point se não tiver nome de volume
      name ??= mountPoint == '/' ? 'Macintosh HD' : mountPoint.split('/').last;

      return DiskInfo(
        name: name,
        mountPoint: mountPoint,
        deviceIdentifier: deviceId,
        fileSystem: fileSystem,
        totalSpace: totalSpace,
        availableSpace: availableSpace,
        isRemovable: isRemovable,
        isInternal: isInternal,
        mediaType: mediaType,
      );
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao obter info de $mountPoint: $e');
      return null;
    }
  }

  /// Lista discos no Linux.
  Future<List<DiskInfo>> _listDisksLinux() async {
    final disks = <DiskInfo>[];

    try {
      // Usa lsblk para listar dispositivos de bloco
      final result = await Process.run('lsblk', ['-J', '-o', 'NAME,SIZE,MOUNTPOINT,FSTYPE,RM,TYPE']);
      if (result.exitCode != 0) return disks;

      // Parseia o JSON...
      // Por simplicidade, lista partições montadas
      final mountResult = await Process.run('df', ['-h']);
      if (mountResult.exitCode == 0) {
        final lines = (mountResult.stdout as String).split('\n').skip(1);
        for (final line in lines) {
          final parts = line.split(RegExp(r'\s+'));
          if (parts.length >= 6) {
            final device = parts[0];
            final mountPoint = parts[5];
            
            if (mountPoint.startsWith('/') && !device.startsWith('tmpfs')) {
              // Obtém mais informações
              final statResult = await Process.run('stat', ['-f', '-c', '%s %a %b', mountPoint]);
              int? totalSpace;
              int? availableSpace;
              
              if (statResult.exitCode == 0) {
                final stats = (statResult.stdout as String).trim().split(' ');
                if (stats.length >= 3) {
                  final blockSize = int.tryParse(stats[0]) ?? 4096;
                  final freeBlocks = int.tryParse(stats[1]) ?? 0;
                  final totalBlocks = int.tryParse(stats[2]) ?? 0;
                  totalSpace = totalBlocks * blockSize;
                  availableSpace = freeBlocks * blockSize;
                }
              }

              disks.add(DiskInfo(
                name: mountPoint == '/' ? 'Root' : mountPoint.split('/').last,
                mountPoint: mountPoint,
                deviceIdentifier: device,
                totalSpace: totalSpace,
                availableSpace: availableSpace,
              ));
            }
          }
        }
      }
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao listar discos Linux: $e');
    }

    return disks;
  }

  /// Lista discos no Windows.
  Future<List<DiskInfo>> _listDisksWindows() async {
    final disks = <DiskInfo>[];

    try {
      // Usa wmic para listar drives lógicos
      final result = await Process.run('wmic', ['logicaldisk', 'get', 'DeviceID,DriveType,FreeSpace,Size,VolumeName', '/format:csv']);
      if (result.exitCode != 0) return disks;

      final lines = (result.stdout as String).split('\n').skip(1);
      for (final line in lines) {
        final parts = line.trim().split(',');
        if (parts.length >= 5) {
          final deviceId = parts[1];
          final driveType = int.tryParse(parts[2]) ?? 0;
          final freeSpace = int.tryParse(parts[3]);
          final totalSpace = int.tryParse(parts[4]);
          final volumeName = parts.length > 5 ? parts[5] : '';

          // DriveType: 2=Removível, 3=Local, 4=Rede, 5=CD
          if (driveType == 2 || driveType == 3) {
            disks.add(DiskInfo(
              name: volumeName.isNotEmpty ? volumeName : deviceId,
              mountPoint: deviceId,
              deviceIdentifier: deviceId,
              totalSpace: totalSpace,
              availableSpace: freeSpace,
              isRemovable: driveType == 2,
              isInternal: driveType == 3,
            ));
          }
        }
      }
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao listar discos Windows: $e');
    }

    return disks;
  }

  /// Lista discos no Android usando path_provider e APIs do sistema.
  Future<List<DiskInfo>> _listDisksAndroid() async {
    final disks = <DiskInfo>[];

    try {
      // Tenta listar usando /proc/mounts primeiro (mais confiável)
      final mountsResult = await _listAndroidMounts();
      if (mountsResult.isNotEmpty) {
        disks.addAll(mountsResult);
        return disks;
      }

      // Fallback: usa path_provider
      // Armazenamento interno do app
      final appDir = await getApplicationDocumentsDirectory();
      final internalInfo = await _getAndroidStorageInfo(
        appDir.path,
        _getLocalizedStorageName('internalStorage'),
        isInternal: true,
      );
      if (internalInfo != null) {
        disks.add(internalInfo);
      }

      // Diretório de armazenamento externo (shared storage)
      final externalDirs = await getExternalStorageDirectories();
      if (externalDirs != null && externalDirs.isNotEmpty) {
        // O primeiro geralmente é o armazenamento principal
        for (var i = 0; i < externalDirs.length; i++) {
          final dir = externalDirs[i];
          final name = i == 0 
              ? _getLocalizedStorageName('primaryStorage')
              : '${_getLocalizedStorageName('externalStorage')} ${i + 1}';
          
          // Tenta obter o caminho raiz do armazenamento
          final rootPath = _getAndroidStorageRoot(dir.path);
          
          final info = await _getAndroidStorageInfo(
            rootPath ?? dir.path,
            name,
            isInternal: i == 0,
          );
          if (info != null && !disks.any((d) => d.mountPoint == info.mountPoint)) {
            disks.add(info);
          }
        }
      }

      // Se ainda não temos discos, adiciona pelo menos o armazenamento do app
      if (disks.isEmpty) {
        final tempDir = await getTemporaryDirectory();
        disks.add(DiskInfo(
          name: _getLocalizedStorageName('deviceStorage'),
          mountPoint: tempDir.path,
          deviceIdentifier: 'internal',
          isInternal: true,
          isRemovable: false,
        ));
      }
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao listar discos Android: $e');
      
      // Fallback de emergência: adiciona pelo menos um disco
      try {
        final appDir = await getApplicationDocumentsDirectory();
        disks.add(DiskInfo(
          name: _getLocalizedStorageName('appStorage'),
          mountPoint: appDir.path,
          deviceIdentifier: 'app_storage',
          isInternal: true,
          isRemovable: false,
        ));
      } catch (_) {
        // Ignora erros do fallback
      }
    }

    return disks;
  }

  /// Lista pontos de montagem Android lendo /proc/mounts.
  Future<List<DiskInfo>> _listAndroidMounts() async {
    final disks = <DiskInfo>[];
    
    try {
      final mountsFile = File('/proc/mounts');
      if (!await mountsFile.exists()) return disks;
      
      final content = await mountsFile.readAsString();
      final lines = content.split('\n');
      
      final seenMounts = <String>{};
      final seenDevices = <String>{};
      
      for (final line in lines) {
        final parts = line.split(' ');
        if (parts.length < 4) continue;
        
        final device = parts[0];
        final mountPoint = parts[1];
        final fileSystem = parts[2];
        
        // Filtra apenas sistemas de arquivos de interesse
        if (!_isRelevantAndroidMount(mountPoint, fileSystem, device)) {
          continue;
        }
        
        // Evita duplicatas pelo mountPoint
        if (seenMounts.contains(mountPoint)) continue;
        
        // Evita duplicatas pelo device (mesmo storage pode ter múltiplos mount points)
        // Normaliza o device para comparação (remove variações como /dev/block/dm-X)
        // Para /dev/fuse, usa mountPoint como identificador (múltiplos storages podem usar fuse)
        final normalizedDevice = _normalizeAndroidDevice(device, mountPoint);
        if (seenDevices.contains(normalizedDevice)) continue;
        
        seenMounts.add(mountPoint);
        seenDevices.add(normalizedDevice);
        
        // Determina o nome do disco
        String name;
        bool isInternal = true;
        bool isRemovable = false;
        
        if (mountPoint == '/data' || mountPoint.contains('emulated/0')) {
          name = _getLocalizedStorageName('internalStorage');
        } else if (mountPoint.contains('sdcard') || mountPoint.contains('external_sd')) {
          name = _getLocalizedStorageName('sdCard');
          isRemovable = true;
          isInternal = false;
        } else if (RegExp(r'/storage/[A-Z0-9]{4}-[A-Z0-9]{4}').hasMatch(mountPoint)) {
          name = _getLocalizedStorageName('externalSdCard');
          isRemovable = true;
          isInternal = false;
        } else if (mountPoint.startsWith('/storage/')) {
          name = '${_getLocalizedStorageName('externalStorage')} ${mountPoint.split('/').last}';
        } else {
          name = mountPoint.split('/').last;
        }
        
        // Obtém informações de espaço usando df se disponível
        int? totalSpace;
        int? availableSpace;
        
        try {
          final dfResult = await Process.run('df', ['-k', mountPoint]);
          if (dfResult.exitCode == 0) {
            final dfOutput = dfResult.stdout as String;
            final dfLines = dfOutput.split('\n');
            if (dfLines.length >= 2) {
              final dfParts = dfLines[1].split(RegExp(r'\s+'));
              if (dfParts.length >= 4) {
                final totalKB = int.tryParse(dfParts[1]);
                final availableKB = int.tryParse(dfParts[3]);
                totalSpace = totalKB != null ? totalKB * 1024 : null;
                availableSpace = availableKB != null ? availableKB * 1024 : null;
              }
            }
          }
        } catch (_) {
          // df pode não estar disponível
        }
        
        disks.add(DiskInfo(
          name: name,
          mountPoint: mountPoint,
          deviceIdentifier: device,
          fileSystem: fileSystem,
          totalSpace: totalSpace,
          availableSpace: availableSpace,
          isInternal: isInternal,
          isRemovable: isRemovable,
        ));
      }
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao ler /proc/mounts: $e');
    }
    
    return disks;
  }

  /// Verifica se um ponto de montagem Android é relevante para listar.
  bool _isRelevantAndroidMount(String mountPoint, String fileSystem, String device) {
    // Sistemas de arquivos relevantes
    final relevantFS = {'ext4', 'f2fs', 'vfat', 'exfat', 'sdcardfs', 'fuse'};
    if (!relevantFS.contains(fileSystem.toLowerCase())) {
      return false;
    }
    
    // Exclui mounts que são aliases conhecidos
    // /storage/self/primary é um link para /storage/emulated/0
    if (mountPoint.contains('/self/primary')) return false;
    if (mountPoint.contains('/self/')) return false;
    
    // Exclui mounts de usuários secundários (multi-user)
    // /storage/emulated/10, /storage/emulated/11, etc são usuários secundários
    final emulatedUserMatch = RegExp(r'/storage/emulated/(\d+)').firstMatch(mountPoint);
    if (emulatedUserMatch != null) {
      final userId = int.tryParse(emulatedUserMatch.group(1)!) ?? 0;
      // Apenas o usuário 0 (principal) é relevante para a maioria dos usos
      if (userId > 0) return false;
    }
    
    // Pontos de montagem relevantes
    if (mountPoint.startsWith('/storage/')) return true;
    if (mountPoint == '/data') return true;
    if (mountPoint.contains('sdcard')) return true;
    
    // Exclui diretórios do sistema
    if (mountPoint.startsWith('/system')) return false;
    if (mountPoint.startsWith('/vendor')) return false;
    if (mountPoint.startsWith('/apex')) return false;
    if (mountPoint.startsWith('/dev')) return false;
    if (mountPoint.startsWith('/proc')) return false;
    if (mountPoint.startsWith('/sys')) return false;
    
    return false;
  }

  /// Normaliza o identificador de dispositivo Android para detectar duplicatas.
  /// Mesmo storage pode aparecer como diferentes devices (ex: /dev/block/dm-X).
  /// Para /dev/fuse, usa o mountPoint como identificador único.
  String _normalizeAndroidDevice(String device, String mountPoint) {
    // Remove variações de caminho que apontam para o mesmo storage
    // Ex: /dev/fuse, /dev/block/..., /data/media, etc.
    
    // Para fuse mounts, usa o mount point como identificador
    // pois múltiplos storages (interno + SD card) podem usar /dev/fuse
    if (device == '/dev/fuse') {
      // Extrai o storage root do mountPoint para identificação
      final storageMatch = RegExp(r'^(/storage/[^/]+)').firstMatch(mountPoint);
      if (storageMatch != null) {
        return storageMatch.group(1)!;
      }
      return mountPoint;
    }
    
    // Para block devices, extrai a parte significativa
    final blockMatch = RegExp(r'/dev/block/(?:dm-\d+|vold/|platform/)').firstMatch(device);
    if (blockMatch != null) {
      // Usa a parte final do device como identificador
      return device.split('/').last;
    }
    
    return device;
  }

  /// Extrai o caminho raiz do armazenamento Android.
  String? _getAndroidStorageRoot(String path) {
    // Padrões comuns: /storage/emulated/0/..., /storage/XXXX-XXXX/...
    final storageMatch = RegExp(r'^(/storage/[^/]+)').firstMatch(path);
    if (storageMatch != null) {
      return storageMatch.group(1);
    }
    
    // Fallback para /data/...
    final dataMatch = RegExp(r'^(/data)').firstMatch(path);
    if (dataMatch != null) {
      return dataMatch.group(1);
    }
    
    return null;
  }

  /// Obtém informações de armazenamento no Android.
  Future<DiskInfo?> _getAndroidStorageInfo(
    String path,
    String name, {
    required bool isInternal,
    bool isRemovable = false,
  }) async {
    try {
      final dir = Directory(path);
      if (!await dir.exists()) return null;

      // Usa StatVFS através de Process.run com df
      final result = await Process.run('df', ['-k', path]);
      if (result.exitCode != 0) {
        // Fallback: retorna disco sem informações de tamanho
        return DiskInfo(
          name: name,
          mountPoint: path,
          deviceIdentifier: path,
          isInternal: isInternal,
          isRemovable: isRemovable,
        );
      }

      final output = result.stdout as String;
      final lines = output.split('\n');
      if (lines.length < 2) return null;

      // Formato: Filesystem 1K-blocks Used Available Use% Mounted on
      final dataLine = lines[1];
      final parts = dataLine.split(RegExp(r'\s+'));
      if (parts.length >= 4) {
        final totalKB = int.tryParse(parts[1]);
        final availableKB = int.tryParse(parts[3]);

        return DiskInfo(
          name: name,
          mountPoint: path,
          deviceIdentifier: parts[0],
          totalSpace: totalKB != null ? totalKB * 1024 : null,
          availableSpace: availableKB != null ? availableKB * 1024 : null,
          isInternal: isInternal,
          isRemovable: isRemovable,
          fileSystem: 'ext4/f2fs',
        );
      }
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao obter info Android: $e');
    }

    return null;
  }

  /// Lista discos no iOS usando path_provider.
  Future<List<DiskInfo>> _listDisksIOS() async {
    final disks = <DiskInfo>[];

    try {
      // No iOS, temos acesso limitado ao sistema de arquivos
      final appDir = await getApplicationDocumentsDirectory();
      
      // Usa df para obter informações do armazenamento
      final result = await Process.run('df', ['-k', appDir.path]);
      
      int? totalSpace;
      int? availableSpace;
      
      if (result.exitCode == 0) {
        final output = result.stdout as String;
        final lines = output.split('\n');
        if (lines.length >= 2) {
          final parts = lines[1].split(RegExp(r'\s+'));
          if (parts.length >= 4) {
            final totalKB = int.tryParse(parts[1]);
            final availableKB = int.tryParse(parts[3]);
            totalSpace = totalKB != null ? totalKB * 1024 : null;
            availableSpace = availableKB != null ? availableKB * 1024 : null;
          }
        }
      }

      disks.add(DiskInfo(
        name: _getLocalizedStorageName('deviceStorage'),
        mountPoint: '/',
        deviceIdentifier: '/dev/disk0s1',
        totalSpace: totalSpace,
        availableSpace: availableSpace,
        isInternal: true,
        isRemovable: false,
        fileSystem: 'APFS',
      ));
    } catch (e) {
      debugPrint('[DiskVerificationService] Erro ao listar discos iOS: $e');
    }

    return disks;
  }

  // ==========================================================================
  // EXECUÇÃO DE TESTES
  // ==========================================================================

  /// Executa todos os testes de verificação em um disco.
  /// 
  /// Emite atualizações de progresso através do [onProgress] callback.
  Stream<DiskVerificationResult> verifyDisk(
    DiskInfo disk, {
    List<DiskVerificationTest>? tests,
  }) async* {
    final testsToRun = tests ?? DiskVerificationTest.values;
    var result = DiskVerificationResult(
      disk: disk,
      startTime: DateTime.now(),
      overallStatus: DiskTestStatus.running,
    );

    yield result;

    final testResults = <DiskTestResult>[];
    var hasFailure = false;
    var hasWarning = false;

    for (final test in testsToRun) {
      // Indica que o teste está em execução
      final runningTestResult = DiskTestResult(
        testName: _getLocalizedTestName(test),
        status: DiskTestStatus.running,
      );
      
      yield result.copyWith(
        tests: [...testResults, runningTestResult],
      );

      // Executa o teste
      DiskTestResult testResult;
      final stopwatch = Stopwatch()..start();

      try {
        testResult = await _runTest(disk, test);
      } catch (e) {
        testResult = DiskTestResult(
          testName: _getLocalizedTestName(test),
          status: DiskTestStatus.failed,
          message: 'Erro ao executar teste: $e',
        );
      }

      stopwatch.stop();

      // Atualiza com a duração
      testResult = DiskTestResult(
        testName: testResult.testName,
        status: testResult.status,
        message: testResult.message,
        details: testResult.details,
        duration: stopwatch.elapsed,
      );

      testResults.add(testResult);

      if (testResult.status == DiskTestStatus.failed) {
        hasFailure = true;
      } else if (testResult.status == DiskTestStatus.warning) {
        hasWarning = true;
      }

      yield result.copyWith(tests: List.from(testResults));
    }

    // Determina status geral
    DiskTestStatus overallStatus;
    if (hasFailure) {
      overallStatus = DiskTestStatus.failed;
    } else if (hasWarning) {
      overallStatus = DiskTestStatus.warning;
    } else {
      overallStatus = DiskTestStatus.passed;
    }

    yield result.copyWith(
      tests: testResults,
      endTime: DateTime.now(),
      overallStatus: overallStatus,
    );
  }

  /// Executa um teste específico.
  Future<DiskTestResult> _runTest(DiskInfo disk, DiskVerificationTest test) async {
    switch (test) {
      case DiskVerificationTest.accessibility:
        return await _testAccessibility(disk);
      case DiskVerificationTest.spaceAnalysis:
        return await _testSpaceAnalysis(disk);
      case DiskVerificationTest.readTest:
        return await _testRead(disk);
      case DiskVerificationTest.fileSystemCheck:
        return await _testFileSystem(disk);
      case DiskVerificationTest.smartStatus:
        return await _testSmart(disk);
    }
  }

  /// Obtém um caminho testável para o disco.
  /// No Android, alguns pontos de montagem não são acessíveis diretamente.
  Future<String> _getTestablePathForDisk(DiskInfo disk) async {
    if (Platform.isAndroid) {
      // No Android, /data e alguns outros pontos não são acessíveis
      if (disk.mountPoint == '/data' || 
          disk.mountPoint.startsWith('/data/') ||
          disk.name.contains('Interno')) {
        // Usa o diretório do app que está no armazenamento interno
        final appDir = await getApplicationDocumentsDirectory();
        return appDir.path;
      }
      
      // Para armazenamento externo, tenta usar o caminho do app nesse storage
      if (disk.mountPoint.startsWith('/storage/')) {
        final externalDirs = await getExternalStorageDirectories();
        if (externalDirs != null) {
          for (final dir in externalDirs) {
            if (dir.path.contains(disk.mountPoint.split('/').last)) {
              return dir.path;
            }
          }
          // Se não encontrou, retorna o primeiro disponível
          if (externalDirs.isNotEmpty) {
            return externalDirs.first.path;
          }
        }
      }
    }
    
    // Para outras plataformas ou se não encontrou alternativa
    return disk.mountPoint;
  }

  /// Teste de acessibilidade: verifica se consegue ler do disco.
  Future<DiskTestResult> _testAccessibility(DiskInfo disk) async {
    try {
      // No Android, usa caminho acessível para o app
      final testPath = await _getTestablePathForDisk(disk);
      final dir = Directory(testPath);
      
      // Verifica se existe
      if (!await dir.exists()) {
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.accessibility),
          status: DiskTestStatus.failed,
          message: 'O ponto de montagem não existe',
        );
      }

      // Tenta listar conteúdo
      try {
        await dir.list().first.timeout(const Duration(seconds: 5));
      } on StateError {
        // Disco vazio, mas acessível
      } on TimeoutException {
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.accessibility),
          status: DiskTestStatus.warning,
          message: 'Disco respondendo lentamente',
        );
      }

      // Verifica permissões de leitura
      final stat = await dir.stat();
      final mode = stat.mode;
      final canRead = (mode & 0x100) != 0; // Owner read permission

      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.accessibility),
        status: canRead ? DiskTestStatus.passed : DiskTestStatus.warning,
        message: canRead ? 'Disco acessível e com permissões corretas' : 'Permissões de leitura limitadas',
        details: {
          'mountPoint': disk.mountPoint,
          'testPath': testPath,
          'exists': true,
          'readable': canRead,
        },
      );
    } catch (e) {
      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.accessibility),
        status: DiskTestStatus.failed,
        message: 'Erro ao acessar disco: $e',
      );
    }
  }

  /// Teste de análise de espaço.
  Future<DiskTestResult> _testSpaceAnalysis(DiskInfo disk) async {
    try {
      int? totalSpace = disk.totalSpace;
      int? availableSpace = disk.availableSpace;

      // Tenta obter informações atualizadas
      if (Platform.isMacOS || Platform.isLinux || Platform.isAndroid) {
        // No Android, usa caminho acessível para o app
        final testPath = Platform.isAndroid 
            ? await _getTestablePathForDisk(disk) 
            : disk.mountPoint;
        
        final result = await Process.run('df', ['-k', testPath]);
        if (result.exitCode == 0) {
          final lines = (result.stdout as String).split('\n');
          if (lines.length > 1) {
            final parts = lines[1].split(RegExp(r'\s+'));
            if (parts.length >= 4) {
              totalSpace = (int.tryParse(parts[1]) ?? 0) * 1024;
              availableSpace = (int.tryParse(parts[3]) ?? 0) * 1024;
            }
          }
        }
      }

      if (totalSpace == null || availableSpace == null) {
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.spaceAnalysis),
          status: DiskTestStatus.warning,
          message: 'Não foi possível obter informações de espaço',
        );
      }

      final usedPercentage = ((totalSpace - availableSpace) / totalSpace) * 100;
      DiskTestStatus status;
      String message;

      if (usedPercentage >= 95) {
        status = DiskTestStatus.failed;
        message = 'Disco quase cheio (${usedPercentage.toStringAsFixed(1)}% usado)';
      } else if (usedPercentage >= 85) {
        status = DiskTestStatus.warning;
        message = 'Espaço ficando baixo (${usedPercentage.toStringAsFixed(1)}% usado)';
      } else {
        status = DiskTestStatus.passed;
        message = 'Espaço adequado (${usedPercentage.toStringAsFixed(1)}% usado)';
      }

      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.spaceAnalysis),
        status: status,
        message: message,
        details: {
          'totalSpace': totalSpace,
          'availableSpace': availableSpace,
          'usedSpace': totalSpace - availableSpace,
          'usedPercentage': usedPercentage,
          'totalFormatted': DiskInfo.formatBytes(totalSpace),
          'availableFormatted': DiskInfo.formatBytes(availableSpace),
        },
      );
    } catch (e) {
      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.spaceAnalysis),
        status: DiskTestStatus.failed,
        message: 'Erro ao analisar espaço: $e',
      );
    }
  }

  /// Teste de leitura: lê arquivos aleatórios para verificar consistência.
  Future<DiskTestResult> _testRead(DiskInfo disk) async {
    try {
      // No Android, usa caminho acessível para o app
      final testPath = await _getTestablePathForDisk(disk);
      final dir = Directory(testPath);
      final random = Random();
      var filesRead = 0;
      var bytesRead = 0;
      var errors = 0;
      var accessErrors = 0;
      final stopwatch = Stopwatch()..start();

      // Diretórios de sistema que devem ser ignorados
      final ignoredDirs = {
        '.Spotlight-V100',
        '.Trashes',
        '.fseventsd',
        '.TemporaryItems',
        '.DocumentRevisions-V100',
        '.MobileBackups',
        'System Volume Information',
        '\$RECYCLE.BIN',
        '.vol',
      };

      // Tenta encontrar arquivos para ler
      final files = <File>[];
      
      // Função para verificar se um caminho deve ser ignorado
      bool shouldIgnore(String path) {
        final parts = path.split('/');
        return parts.any((part) => ignoredDirs.contains(part));
      }

      // Lista apenas o primeiro nível para evitar erros de permissão
      try {
        await for (final entity in dir.list(recursive: false, followLinks: false)) {
          if (shouldIgnore(entity.path)) continue;
          
          if (entity is File) {
            try {
              final stat = await entity.stat();
              if (stat.size > 0 && stat.size < 10 * 1024 * 1024) {
                files.add(entity);
              }
            } catch (_) {
              accessErrors++;
            }
          } else if (entity is Directory) {
            // Lista segundo nível
            try {
              await for (final subEntity in entity.list(recursive: false, followLinks: false)) {
                if (shouldIgnore(subEntity.path)) continue;
                
                if (subEntity is File) {
                  try {
                    final stat = await subEntity.stat();
                    if (stat.size > 0 && stat.size < 10 * 1024 * 1024) {
                      files.add(subEntity);
                    }
                  } catch (_) {
                    accessErrors++;
                  }
                }
                if (files.length >= 100) break;
              }
            } catch (_) {
              accessErrors++;
            }
          }
          if (files.length >= 100) break;
        }
      } catch (e) {
        accessErrors++;
        debugPrint('[DiskVerificationService] Erro ao listar diretório: $e');
      }

      if (files.isEmpty) {
        // Se não encontrou arquivos mas teve erros de acesso, isso é esperado em alguns discos
        if (accessErrors > 0) {
          return DiskTestResult(
            testName: _getLocalizedTestName(DiskVerificationTest.readTest),
            status: DiskTestStatus.passed,
            message: 'Disco acessível (alguns diretórios de sistema protegidos)',
            details: {'accessErrors': accessErrors},
          );
        }
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.readTest),
          status: DiskTestStatus.skipped,
          message: 'Nenhum arquivo acessível encontrado para teste',
        );
      }

      // Seleciona alguns arquivos aleatórios para ler
      final filesToTest = <File>[];
      for (var i = 0; i < min(10, files.length); i++) {
        filesToTest.add(files[random.nextInt(files.length)]);
      }

      // Lê os arquivos
      for (final file in filesToTest) {
        try {
          final bytes = await file.readAsBytes();
          filesRead++;
          bytesRead += bytes.length;
        } catch (e) {
          errors++;
          debugPrint('[DiskVerificationService] Erro ao ler ${file.path}: $e');
        }
      }

      stopwatch.stop();

      final readSpeed = bytesRead / (stopwatch.elapsedMilliseconds / 1000); // bytes/s

      DiskTestStatus status;
      String message;

      if (errors > filesToTest.length ~/ 2) {
        status = DiskTestStatus.failed;
        message = 'Muitos erros de leitura ($errors de ${filesToTest.length} arquivos)';
      } else if (errors > 0) {
        status = DiskTestStatus.warning;
        message = 'Alguns erros de leitura ($errors de ${filesToTest.length} arquivos)';
      } else {
        status = DiskTestStatus.passed;
        message = 'Leitura consistente (${DiskInfo.formatBytes(bytesRead)} em ${stopwatch.elapsed.inMilliseconds}ms)';
      }

      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.readTest),
        status: status,
        message: message,
        details: {
          'filesRead': filesRead,
          'bytesRead': bytesRead,
          'errors': errors,
          'readSpeedBytesPerSec': readSpeed,
          'readSpeedFormatted': '${DiskInfo.formatBytes(readSpeed.round())}/s',
        },
      );
    } catch (e) {
      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.readTest),
        status: DiskTestStatus.failed,
        message: 'Erro no teste de leitura: $e',
      );
    }
  }

  /// Teste de sistema de arquivos usando ferramentas do sistema.
  Future<DiskTestResult> _testFileSystem(DiskInfo disk) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        // No Android/iOS, não temos acesso a ferramentas de verificação de FS
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
          status: DiskTestStatus.passed,
          message: 'Sistema de arquivos gerenciado pelo sistema operacional',
          details: {
            'fileSystem': disk.fileSystem ?? 'ext4/f2fs',
            'note': 'Verificação profunda não disponível em dispositivos móveis',
          },
        );
      } else if (Platform.isMacOS) {
        // Usa diskutil verifyVolume
        final result = await Process.run(
          'diskutil',
          ['verifyVolume', disk.mountPoint],
        ).timeout(const Duration(minutes: 5));

        final output = '${result.stdout}\n${result.stderr}';
        
        if (result.exitCode == 0) {
          return DiskTestResult(
            testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
            status: DiskTestStatus.passed,
            message: 'Sistema de arquivos verificado com sucesso',
            details: {'output': output.trim()},
          );
        } else {
          // Verifica se há erros específicos
          if (output.contains('appears to be OK')) {
            return DiskTestResult(
              testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
              status: DiskTestStatus.passed,
              message: 'Sistema de arquivos OK',
              details: {'output': output.trim()},
            );
          }
          
          return DiskTestResult(
            testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
            status: DiskTestStatus.warning,
            message: 'Verificação retornou avisos',
            details: {'output': output.trim()},
          );
        }
      } else if (Platform.isLinux) {
        // No Linux, fsck requer privilégios e disco desmontado
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
          status: DiskTestStatus.skipped,
          message: 'Verificação de sistema de arquivos requer privilégios de administrador',
        );
      } else if (Platform.isWindows) {
        // No Windows, chkdsk requer privilégios
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
          status: DiskTestStatus.skipped,
          message: 'Verificação de sistema de arquivos requer privilégios de administrador',
        );
      }

      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
        status: DiskTestStatus.skipped,
        message: 'Verificação não disponível nesta plataforma',
      );
    } on TimeoutException {
      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
        status: DiskTestStatus.warning,
        message: 'Verificação demorou muito e foi cancelada',
      );
    } catch (e) {
      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.fileSystemCheck),
        status: DiskTestStatus.failed,
        message: 'Erro na verificação: $e',
      );
    }
  }

  /// Teste S.M.A.R.T. usando smartctl (se disponível).
  Future<DiskTestResult> _testSmart(DiskInfo disk) async {
    try {
      // No Android/iOS, não temos acesso a S.M.A.R.T.
      if (Platform.isAndroid || Platform.isIOS) {
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.smartStatus),
          status: DiskTestStatus.skipped,
          message: 'S.M.A.R.T. não disponível em dispositivos móveis',
          details: {
            'note': 'Armazenamento flash de dispositivos móveis não suporta S.M.A.R.T.',
          },
        );
      }

      // Verifica se smartctl está disponível
      final whichResult = await Process.run('which', ['smartctl']);
      if (whichResult.exitCode != 0) {
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.smartStatus),
          status: DiskTestStatus.skipped,
          message: 'smartctl não instalado (instale smartmontools)',
          details: {'suggestion': 'brew install smartmontools'},
        );
      }

      // Obtém o dispositivo físico
      String devicePath;
      if (Platform.isMacOS) {
        devicePath = '/dev/${disk.deviceIdentifier.replaceAll('s', '')}'; // Remove partição
        // Pega apenas o disco base (disk0, disk1, etc.)
        final match = RegExp(r'(disk\d+)').firstMatch(disk.deviceIdentifier);
        if (match != null) {
          devicePath = '/dev/${match.group(1)}';
        }
      } else {
        devicePath = disk.deviceIdentifier;
      }

      // Executa smartctl
      final result = await Process.run(
        'smartctl',
        ['-H', '-A', devicePath],
      ).timeout(const Duration(seconds: 30));

      final output = '${result.stdout}\n${result.stderr}';

      // Analisa resultado
      if (output.contains('SMART overall-health self-assessment test result: PASSED')) {
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.smartStatus),
          status: DiskTestStatus.passed,
          message: 'S.M.A.R.T. indica disco saudável',
          details: _parseSmartOutput(output),
        );
      } else if (output.contains('SMART overall-health self-assessment test result: FAILED')) {
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.smartStatus),
          status: DiskTestStatus.failed,
          message: 'S.M.A.R.T. indica problemas no disco!',
          details: _parseSmartOutput(output),
        );
      } else if (output.contains('Unable to detect device type') || 
                 output.contains('Smartctl open device') ||
                 output.contains('Permission denied')) {
        return DiskTestResult(
          testName: _getLocalizedTestName(DiskVerificationTest.smartStatus),
          status: DiskTestStatus.skipped,
          message: 'S.M.A.R.T. não suportado ou requer privilégios',
        );
      }

      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.smartStatus),
        status: DiskTestStatus.warning,
        message: 'Resultado S.M.A.R.T. inconclusivo',
        details: {'output': output.trim()},
      );
    } on TimeoutException {
      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.smartStatus),
        status: DiskTestStatus.warning,
        message: 'Leitura S.M.A.R.T. demorou muito',
      );
    } catch (e) {
      return DiskTestResult(
        testName: _getLocalizedTestName(DiskVerificationTest.smartStatus),
        status: DiskTestStatus.skipped,
        message: 'S.M.A.R.T. não disponível: $e',
      );
    }
  }

  /// Parseia output do smartctl para extrair informações relevantes.
  Map<String, dynamic> _parseSmartOutput(String output) {
    final details = <String, dynamic>{};

    // Extrai temperatura
    final tempMatch = RegExp(r'Temperature_Celsius\s+\d+\s+\d+\s+\d+\s+\S+\s+\S+\s+\S+\s+(\d+)').firstMatch(output);
    if (tempMatch != null) {
      details['temperature'] = '${tempMatch.group(1)}°C';
    }

    // Extrai horas de uso
    final hoursMatch = RegExp(r'Power_On_Hours\s+\d+\s+\d+\s+\d+\s+\S+\s+\S+\s+\S+\s+(\d+)').firstMatch(output);
    if (hoursMatch != null) {
      details['powerOnHours'] = int.tryParse(hoursMatch.group(1)!);
    }

    // Extrai setores realocados
    final reallocMatch = RegExp(r'Reallocated_Sector_Ct\s+\d+\s+\d+\s+\d+\s+\S+\s+\S+\s+\S+\s+(\d+)').firstMatch(output);
    if (reallocMatch != null) {
      details['reallocatedSectors'] = int.tryParse(reallocMatch.group(1)!);
    }

    return details;
  }
}
