import 'dart:io';

/// Serviço para calcular tamanhos de arquivos/pastas e espaço em disco.
class DiskSpaceService {
  const DiskSpaceService();

  /// Calcula o tamanho total de uma lista de caminhos (arquivos e/ou pastas).
  /// Retorna o tamanho em bytes.
  Future<int> calculateTotalSize(List<String> paths) async {
    int totalSize = 0;

    for (final path in paths) {
      final entity = FileSystemEntity.typeSync(path);
      if (entity == FileSystemEntityType.file) {
        totalSize += await _getFileSize(path);
      } else if (entity == FileSystemEntityType.directory) {
        totalSize += await _getDirectorySize(path);
      }
    }

    return totalSize;
  }

  /// Obtém o espaço disponível no disco onde o caminho está localizado.
  /// Retorna o espaço disponível em bytes, ou null se não for possível obter.
  Future<int?> getAvailableSpace(String path) async {
    try {
      if (Platform.isIOS) {
        // No iOS, não podemos usar comandos shell
        // Usamos uma estimativa baseada no diretório de documentos
        return await _getAvailableSpaceIOS();
      } else if (Platform.isMacOS || Platform.isLinux || Platform.isAndroid) {
        return await _getAvailableSpaceUnix(path);
      } else if (Platform.isWindows) {
        return await _getAvailableSpaceWindows(path);
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Obtém espaço disponível no iOS usando FileStat
  Future<int?> _getAvailableSpaceIOS() async {
    try {
      // No iOS, retornamos null pois não há API nativa simples
      // O app precisaria de um plugin específico para isso
      // Por enquanto, retornamos um valor estimado ou null
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<int> _getFileSize(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        return await file.length();
      }
    } catch (_) {
      // Ignora erros de permissão
    }
    return 0;
  }

  Future<int> _getDirectorySize(String path) async {
    int size = 0;
    try {
      final directory = Directory(path);
      if (!await directory.exists()) {
        return 0;
      }

      await for (final entity in directory.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          try {
            size += await entity.length();
          } catch (_) {
            // Ignora erros de permissão em arquivos individuais
          }
        }
      }
    } catch (_) {
      // Ignora erros de permissão na pasta
    }
    return size;
  }

  Future<int?> _getAvailableSpaceUnix(String path) async {
    try {
      // Garante que o caminho existe, senão usa o diretório pai
      String targetPath = path;
      
      // No Android, se o caminho começa com /storage, tentar usar /storage/emulated/0
      if (Platform.isAndroid) {
        if (!await Directory(targetPath).exists() && !await File(targetPath).exists()) {
          // Tenta usar o storage interno como fallback
          targetPath = '/storage/emulated/0';
        }
      }
      
      while (!await Directory(targetPath).exists() && !await File(targetPath).exists()) {
        final parent = Directory(targetPath).parent.path;
        if (parent == targetPath) break;
        targetPath = parent;
      }

      final result = await Process.run('df', ['-k', targetPath]);
      if (result.exitCode != 0) {
        // Fallback: tenta df sem parâmetros e pega o storage principal
        if (Platform.isAndroid) {
          final fallbackResult = await Process.run('df', ['-k', '/storage/emulated/0']);
          if (fallbackResult.exitCode == 0) {
            return _parseDfOutput(fallbackResult.stdout as String);
          }
        }
        return null;
      }

      return _parseDfOutput(result.stdout as String);
    } catch (_) {
      return null;
    }
  }

  int? _parseDfOutput(String output) {
    final lines = output.split('\n');
    if (lines.length < 2) return null;

    // Formato: Filesystem 1K-blocks Used Available Use% Mounted
    final parts = lines[1].split(RegExp(r'\s+'));
    if (parts.length >= 4) {
      final availableKb = int.tryParse(parts[3]);
      if (availableKb != null) {
        return availableKb * 1024; // Converte KB para bytes
      }
    }
    return null;
  }

  Future<int?> _getAvailableSpaceWindows(String path) async {
    try {
      // Extrai a letra do drive
      final drive = path.substring(0, 2); // Ex: "C:"
      
      final result = await Process.run(
        'wmic',
        ['logicaldisk', 'where', 'DeviceID="$drive"', 'get', 'FreeSpace'],
        runInShell: true,
      );
      
      if (result.exitCode != 0) return null;

      final lines = (result.stdout as String).split('\n');
      for (final line in lines) {
        final trimmed = line.trim();
        if (trimmed.isNotEmpty && trimmed != 'FreeSpace') {
          final freeSpace = int.tryParse(trimmed);
          if (freeSpace != null) {
            return freeSpace;
          }
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Formata bytes para exibição legível (KB, MB, GB, TB).
  static String formatBytes(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else if (bytes < 1024 * 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024 * 1024)).toStringAsFixed(2)} TB';
    }
  }
}
