import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../models/backup_execution_config.dart';
import '../models/backup_routine.dart';
import '../repositories/backup_repository.dart';
import 'compression_service.dart';
import 'device_info_service.dart';
import 'email_notification_service.dart';
import 'encryption_service.dart';
import 'notification_localizations.dart';
import 'notification_service.dart';
import 'telegram_notification_service.dart';

class BackupEngineService {
  const BackupEngineService({
    required BackupRepository repository,
    required CompressionService compressionService,
    required EncryptionService encryptionService,
  }) : _repository = repository,
       _compressionService = compressionService,
       _encryptionService = encryptionService;

  final BackupRepository _repository;
  final CompressionService _compressionService;
  final EncryptionService _encryptionService;

  Future<BackupRoutine?> runRoutine(String routineId) async {
    final routine = await _repository.getRoutineById(routineId);
    if (routine == null) {
      return null;
    }

    // Obtém o nome do dispositivo para notificações (antes do try para estar disponível no catch)
    String deviceName;
    try {
      deviceName = await DeviceInfoService.getInstance().getDeviceName();
    } catch (_) {
      deviceName = Platform.localHostname;
    }

    try {
      var currentRoutine = routine.copyWith(
        status: 'Preparando backup...',
        progress: 0.05,
        isCompleted: false,
      );
      await _repository.updateRoutine(currentRoutine);

      // Notifica via Telegram que o backup iniciou
      try {
        final telegramService = await TelegramNotificationService.getInstance();
        await telegramService.sendNotification(
          eventType: NotificationEventType.backupStarted,
          routineName: routine.name,
          deviceName: deviceName,
        );
      } catch (_) {
        // Ignora erros de notificação
      }

      // Notifica via Email que o backup iniciou
      try {
        final emailService = await EmailNotificationService.getInstance();
        await emailService.sendNotification(
          eventType: NotificationEventType.backupStarted,
          routineName: routine.name,
          deviceName: deviceName,
        );
      } catch (_) {
        // Ignora erros de notificação
      }

      // Determina o diretório de destino
      // No iOS, usamos o diretório de documentos do app se o destino não for acessível
      String destinationPath = routine.destinationPath;
      
      if (Platform.isIOS) {
        try {
          final testDir = Directory(destinationPath);
          await testDir.create(recursive: true);
        } catch (_) {
          // Fallback para diretório de documentos no iOS
          final docsDir = await getApplicationDocumentsDirectory();
          final backupsDir = Directory(p.join(docsDir.path, 'Backups'));
          await backupsDir.create(recursive: true);
          destinationPath = backupsDir.path;
        }
      }

      final destinationDir = Directory(destinationPath);
      await destinationDir.create(recursive: true);

      final validSources = routine.sourcePaths
          .where(
            (source) =>
                FileSystemEntity.typeSync(source) != FileSystemEntityType.notFound,
          )
          .toList();

      if (validSources.isEmpty) {
        throw StateError('Nenhuma origem válida foi encontrada para o backup.');
      }

      // Define o nome base do arquivo de saída
      // Se usar nome personalizado, usa o nome definido pelo usuário
      // Caso contrário, usa o nome da rotina + timestamp
      final String fileNameBase;
      if (routine.executionConfig.useCustomBackupName && 
          routine.executionConfig.customBackupName != null &&
          routine.executionConfig.customBackupName!.isNotEmpty) {
        fileNameBase = _sanitizeFileName(routine.executionConfig.customBackupName!);
      } else {
        fileNameBase = '${_sanitizeFileName(routine.name)}_${DateTime.now().millisecondsSinceEpoch}';
      }

      // Determina a estratégia de backup:
      // 1. Compressão + Criptografia: ZIP → AES
      // 2. Apenas Compressão: ZIP
      // 3. Apenas Criptografia: ZIP temp → AES (sem copiar arquivos para destino)
      // 4. Nenhum: Cópia direta dos arquivos
      
      final hasCompression = routine.executionConfig.compressionEnabled;
      final hasEncryption = routine.executionConfig.encryptionEnabled;

      String? payloadPath;
      
      if (hasCompression) {
        currentRoutine = currentRoutine.copyWith(
          status: 'Compactando arquivos...',
          progress: 0.15,
        );
        await _repository.updateRoutine(currentRoutine);

        // Cria arquivo compactado no destino
        payloadPath = await _compressionService.compressSources(
          sourcePaths: validSources,
          outputDirectoryPath: destinationDir.path,
          outputBaseName: fileNameBase,
          format: routine.executionConfig.compressionFormat,
        );

        currentRoutine = currentRoutine.copyWith(
          status: 'Compactação concluída',
          progress: 0.55,
        );
        await _repository.updateRoutine(currentRoutine);
      } else if (!hasEncryption) {
        currentRoutine = currentRoutine.copyWith(
          status: 'Copiando arquivos...',
          progress: 0.15,
        );
        await _repository.updateRoutine(currentRoutine);

        // Sem compressão e sem criptografia: copia arquivos diretamente
        payloadPath = await _copySourcesToDirectory(
          sourcePaths: validSources,
          outputDirectoryPath: destinationDir.path,
          outputBaseName: fileNameBase,
          useCustomName: routine.executionConfig.useCustomBackupName,
          customName: routine.executionConfig.customBackupName,
        );

        currentRoutine = currentRoutine.copyWith(
          status: 'Cópia concluída',
          progress: 0.65,
        );
        await _repository.updateRoutine(currentRoutine);
      }
      // Se apenas criptografia (sem compressão), não copia nada ainda
      // O processamento será feito no bloco de criptografia abaixo

      if (hasEncryption) {
        currentRoutine = currentRoutine.copyWith(
          status: 'Preparando criptografia...',
          progress: 0.6,
        );
        await _repository.updateRoutine(currentRoutine);

        final keyRef = routine.executionConfig.encryptionKeyRef;
        if (keyRef == null || keyRef.isEmpty) {
          throw StateError(
            'Criptografia ativa, mas nenhuma chave foi informada na rotina.',
          );
        }

        final encryptedOutputPath = p.join(
          destinationDir.path,
          '$fileNameBase.aes',
        );

        String sourceForEncryption;
        String? tempFileToDelete;

        if (hasCompression && payloadPath != null) {
          // Se já comprimimos, o payloadPath é o arquivo ZIP
          sourceForEncryption = payloadPath;
        } else {
          currentRoutine = currentRoutine.copyWith(
            status: 'Preparando arquivos para criptografia...',
            progress: 0.65,
          );
          await _repository.updateRoutine(currentRoutine);

          // Se não comprimimos, precisamos criar um ZIP temporário das fontes originais.
          // Usa Directory.systemTemp (dart:io) em vez de path_provider para evitar
          // o carregamento de objective_c no macOS, que causa falha com DOBJC_initializeApi.
          final tempBaseName = 'shadowsync_enc_${DateTime.now().millisecondsSinceEpoch}';
          final tempDirPath = p.join(Directory.systemTemp.path, tempBaseName);
          await Directory(tempDirPath).create(recursive: true);

          sourceForEncryption = await _compressionService.compressSources(
            sourcePaths: validSources, // Usa as fontes originais
            outputDirectoryPath: tempDirPath,
            outputBaseName: tempBaseName,
            format: CompressionFormat.zip,
          );
          tempFileToDelete = sourceForEncryption;
        }

        // Verifica se o arquivo fonte para criptografia existe
        final sourceFile = File(sourceForEncryption);
        if (!await sourceFile.exists()) {
          throw StateError(
            'Arquivo para criptografia não encontrado: $sourceForEncryption',
          );
        }

        currentRoutine = currentRoutine.copyWith(
          status: 'Criptografando dados...',
          progress: 0.75,
        );
        await _repository.updateRoutine(currentRoutine);

        await _encryptionService.encryptFile(
          inputFilePath: sourceForEncryption,
          outputFilePath: encryptedOutputPath,
          passphrase: keyRef,
        );

        currentRoutine = currentRoutine.copyWith(
          status: 'Limpando arquivos temporários...',
          progress: 0.88,
        );
        await _repository.updateRoutine(currentRoutine);

        // Remove o arquivo temporário criado para criptografia
        if (tempFileToDelete != null) {
          final tempFile = File(tempFileToDelete);
          if (await tempFile.exists()) {
            await tempFile.delete();
          }
        }
        
        // Se a compressão estava ativada, remove o arquivo compactado original
        // pois agora temos o arquivo .aes criptografado
        if (hasCompression && payloadPath != null) {
          final originalPayloadFile = File(payloadPath);
          if (await originalPayloadFile.exists()) {
            await originalPayloadFile.delete();
          }
        }

        currentRoutine = currentRoutine.copyWith(
          status: 'Concluindo backup...',
          progress: 0.95,
        );
        await _repository.updateRoutine(currentRoutine);
      }

      final completedAt = DateTime.now();
      final completedRoutine = currentRoutine.copyWith(
        status: 'Último backup: ${_formatDate(completedAt)}',
        progress: 1,
        isCompleted: true,
        lastRunAt: completedAt,
        nextRunAt: _calculateNextRunAt(routine, completedAt),
      );

      await _repository.updateRoutine(completedRoutine);

      // Notifica que o backup foi concluído com sucesso
      try {
        final notificationService = await NotificationService.getInstance();
        await notificationService.notifyBackupCompleted(
          routineName: routine.name,
          success: true,
        );
      } catch (_) {
        // Ignora erros de notificação
      }

      // Notifica via Telegram e Email que o backup foi concluído com sucesso
      final successDetails = NotificationLocalizations.getInstance().backupCompletedAt(_formatDate(completedAt));
      try {
        final telegramService = await TelegramNotificationService.getInstance();
        await telegramService.sendNotification(
          eventType: NotificationEventType.backupSuccess,
          routineName: routine.name,
          details: successDetails,
          deviceName: deviceName,
        );
      } catch (_) {
        // Ignora erros de notificação
      }

      try {
        final emailService = await EmailNotificationService.getInstance();
        await emailService.sendNotification(
          eventType: NotificationEventType.backupSuccess,
          routineName: routine.name,
          details: successDetails,
          deviceName: deviceName,
        );
      } catch (_) {
        // Ignora erros de notificação
      }

      return completedRoutine;
    } catch (error) {
      final failedRoutine = routine.copyWith(
        status: 'Falha: $error',
        progress: 0,
        isCompleted: false,
      );
      await _repository.updateRoutine(failedRoutine);

      // Notifica que o backup falhou
      try {
        final notificationService = await NotificationService.getInstance();
        await notificationService.notifyBackupCompleted(
          routineName: routine.name,
          success: false,
          errorMessage: error.toString(),
        );
      } catch (_) {
        // Ignora erros de notificação
      }

      // Notifica via Telegram que o backup falhou
      try {
        final telegramService = await TelegramNotificationService.getInstance();
        await telegramService.sendNotification(
          eventType: NotificationEventType.backupFailure,
          routineName: routine.name,
          errorMessage: error.toString(),
          deviceName: deviceName,
        );
      } catch (_) {
        // Ignora erros de notificação
      }

      // Notifica via Email que o backup falhou
      try {
        final emailService = await EmailNotificationService.getInstance();
        await emailService.sendNotification(
          eventType: NotificationEventType.backupFailure,
          routineName: routine.name,
          errorMessage: error.toString(),
          deviceName: deviceName,
        );
      } catch (_) {
        // Ignora erros de notificação
      }

      return failedRoutine;
    }
  }

  Future<String> _copySourcesToDirectory({
    required List<String> sourcePaths,
    required String outputDirectoryPath,
    required String outputBaseName,
    bool useCustomName = false,
    String? customName,
  }) async {
    // Se usar nome personalizado, cria uma pasta com esse nome
    // Caso contrário, copia diretamente para o destino mantendo os nomes originais
    final String targetBasePath;
    
    if (useCustomName && customName != null && customName.isNotEmpty) {
      // Cria pasta com nome personalizado
      targetBasePath = p.join(outputDirectoryPath, customName);
      await Directory(targetBasePath).create(recursive: true);
    } else {
      // Copia diretamente para o destino
      targetBasePath = outputDirectoryPath;
    }

    for (final sourcePath in sourcePaths) {
      final entityType = FileSystemEntity.typeSync(sourcePath);

      if (entityType == FileSystemEntityType.file) {
        final sourceFile = File(sourcePath);
        final targetFile = File(p.join(targetBasePath, p.basename(sourcePath)));
        await targetFile.parent.create(recursive: true);
        await sourceFile.copy(targetFile.path);
        continue;
      }

      if (entityType == FileSystemEntityType.directory) {
        // Copia a pasta mantendo o nome original
        await _copyDirectory(
          sourcePath: sourcePath,
          destinationPath: p.join(targetBasePath, p.basename(sourcePath)),
        );
      }
    }

    return targetBasePath;
  }

  Future<void> _copyDirectory({
    required String sourcePath,
    required String destinationPath,
  }) async {
    final sourceDir = Directory(sourcePath);
    final destinationDir = Directory(destinationPath);
    await destinationDir.create(recursive: true);

    final entities = sourceDir.listSync(recursive: true, followLinks: false);
    for (final entity in entities) {
      final relativePath = p.relative(entity.path, from: sourcePath);
      final targetPath = p.join(destinationPath, relativePath);

      if (entity is Directory) {
        await Directory(targetPath).create(recursive: true);
      } else if (entity is File) {
        await File(targetPath).parent.create(recursive: true);
        await entity.copy(targetPath);
      }
    }
  }

  DateTime? _calculateNextRunAt(BackupRoutine routine, DateTime from) {
    switch (routine.scheduleType) {
      case ScheduleType.manual:
        return null;
      case ScheduleType.daily:
        return from.add(const Duration(days: 1));
      case ScheduleType.weekly:
        return from.add(const Duration(days: 7));
      case ScheduleType.interval:
        final value = routine.scheduleValue ?? '';
        final minutes = _readIntervalMinutes(value);
        return from.add(Duration(minutes: minutes));
    }
    return null;
  }

  int _readIntervalMinutes(String rawValue) {
    final digitsOnly = rawValue.replaceAll(RegExp(r'[^0-9]'), '');
    final parsed = int.tryParse(digitsOnly);
    return parsed == null || parsed <= 0 ? 30 : parsed;
  }

  String _sanitizeFileName(String input) {
    return input
        .trim()
        .replaceAll(RegExp(r'\s+'), '_')
        .replaceAll(RegExp(r'[^a-zA-Z0-9_\-]'), '')
        .toLowerCase();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }
}
