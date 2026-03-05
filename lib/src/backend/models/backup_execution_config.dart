enum CompressionFormat { zip, tar }

class BackupExecutionConfig {
  const BackupExecutionConfig({
    required this.compressionEnabled,
    required this.compressionFormat,
    required this.encryptionEnabled,
    this.encryptionKeyRef,
    this.retentionCount,
    this.useCustomBackupName = false,
    this.customBackupName,
  });

  final bool compressionEnabled;
  final CompressionFormat compressionFormat;
  final bool encryptionEnabled;
  final String? encryptionKeyRef;
  final int? retentionCount;
  
  /// Se deve usar um nome personalizado para a pasta de backup
  final bool useCustomBackupName;
  
  /// Nome personalizado para a pasta de backup (se useCustomBackupName for true)
  final String? customBackupName;

  BackupExecutionConfig copyWith({
    bool? compressionEnabled,
    CompressionFormat? compressionFormat,
    bool? encryptionEnabled,
    String? encryptionKeyRef,
    int? retentionCount,
    bool? useCustomBackupName,
    String? customBackupName,
  }) {
    return BackupExecutionConfig(
      compressionEnabled: compressionEnabled ?? this.compressionEnabled,
      compressionFormat: compressionFormat ?? this.compressionFormat,
      encryptionEnabled: encryptionEnabled ?? this.encryptionEnabled,
      encryptionKeyRef: encryptionKeyRef ?? this.encryptionKeyRef,
      retentionCount: retentionCount ?? this.retentionCount,
      useCustomBackupName: useCustomBackupName ?? this.useCustomBackupName,
      customBackupName: customBackupName ?? this.customBackupName,
    );
  }
}
