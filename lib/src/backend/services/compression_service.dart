import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as p;

import '../models/backup_execution_config.dart';

class CompressionService {
  const CompressionService();

  Future<String> compressSources({
    required List<String> sourcePaths,
    required String outputDirectoryPath,
    required String outputBaseName,
    required CompressionFormat format,
  }) async {
    final archive = Archive();

    for (final sourcePath in sourcePaths) {
      final entityType = FileSystemEntity.typeSync(sourcePath);
      if (entityType == FileSystemEntityType.notFound) {
        continue;
      }

      if (entityType == FileSystemEntityType.file) {
        await _addFile(
          archive: archive,
          filePath: sourcePath,
          archivePath: p.basename(sourcePath),
        );
      }

      if (entityType == FileSystemEntityType.directory) {
        await _addDirectory(
          archive: archive,
          directoryPath: sourcePath,
          relativeBasePath: p.dirname(sourcePath),
        );
      }
    }

    final bytes = switch (format) {
      CompressionFormat.zip =>
        ZipEncoder().encode(archive, level: DeflateLevel.bestCompression),
      CompressionFormat.tar => TarEncoder().encode(archive),
    };

    final extension = format == CompressionFormat.zip ? 'zip' : 'tar';
    final outputPath = p.join(outputDirectoryPath, '$outputBaseName.$extension');

    await File(outputPath).writeAsBytes(bytes, flush: true);
    return outputPath;
  }

  Future<void> _addDirectory({
    required Archive archive,
    required String directoryPath,
    required String relativeBasePath,
  }) async {
    final entities = Directory(directoryPath).listSync(
      recursive: true,
      followLinks: false,
    );

    for (final entity in entities) {
      if (entity is! File) {
        continue;
      }

      final relativePath = p.relative(entity.path, from: relativeBasePath);
      await _addFile(
        archive: archive,
        filePath: entity.path,
        archivePath: relativePath,
      );
    }
  }

  Future<void> _addFile({
    required Archive archive,
    required String filePath,
    required String archivePath,
  }) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    archive.addFile(ArchiveFile(archivePath, bytes.length, bytes));
  }

  /// Descompacta um arquivo ZIP ou TAR para o diretório de destino.
  ///
  /// Retorna a lista de caminhos dos arquivos extraídos.
  Future<List<String>> extractArchive({
    required String archivePath,
    required String outputDirectoryPath,
  }) async {
    final archiveFile = File(archivePath);
    if (!await archiveFile.exists()) {
      throw StateError('Arquivo não encontrado: $archivePath');
    }

    final bytes = await archiveFile.readAsBytes();
    
    Archive? archive;
    final extension = p.extension(archivePath).toLowerCase();
    
    if (extension == '.zip') {
      archive = ZipDecoder().decodeBytes(bytes);
    } else if (extension == '.tar') {
      archive = TarDecoder().decodeBytes(bytes);
    } else {
      // Tenta detectar pelo conteúdo
      try {
        archive = ZipDecoder().decodeBytes(bytes);
      } catch (_) {
        try {
          archive = TarDecoder().decodeBytes(bytes);
        } catch (_) {
          throw StateError('Formato de arquivo não suportado');
        }
      }
    }

    final extractedPaths = <String>[];
    
    for (final file in archive) {
      final outputPath = p.join(outputDirectoryPath, file.name);
      
      if (file.isFile) {
        final outputFile = File(outputPath);
        await outputFile.parent.create(recursive: true);
        await outputFile.writeAsBytes(file.content as List<int>);
        extractedPaths.add(outputPath);
      } else {
        await Directory(outputPath).create(recursive: true);
      }
    }
    
    return extractedPaths;
  }
}
