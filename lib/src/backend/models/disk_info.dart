// ============================================================================
// APLICATIVO: ShadowSync - Gerenciador de Backups
// AUTOR: Eng. Hewerton Bianchi
// DATA: 2024-06-15
// DESCRIÇÃO: Modelo que representa informações de um disco/volume do sistema.
// ============================================================================

/// Representa informações de um disco ou volume do sistema.
class DiskInfo {
  const DiskInfo({
    required this.name,
    required this.mountPoint,
    required this.deviceIdentifier,
    this.fileSystem,
    this.totalSpace,
    this.availableSpace,
    this.isRemovable = false,
    this.isInternal = true,
    this.mediaType,
  });

  /// Nome do volume (ex: "Macintosh HD", "Backup Disk")
  final String name;

  /// Ponto de montagem (ex: "/", "/Volumes/Backup")
  final String mountPoint;

  /// Identificador do dispositivo (ex: "disk0s2", "/dev/sda1")
  final String deviceIdentifier;

  /// Sistema de arquivos (ex: "APFS", "HFS+", "NTFS", "ext4")
  final String? fileSystem;

  /// Espaço total em bytes
  final int? totalSpace;

  /// Espaço disponível em bytes
  final int? availableSpace;

  /// Se é um disco removível (HD externo, pen drive)
  final bool isRemovable;

  /// Se é um disco interno
  final bool isInternal;

  /// Tipo de mídia (SSD, HDD, etc.)
  final String? mediaType;

  /// Espaço usado em bytes
  int? get usedSpace {
    if (totalSpace != null && availableSpace != null) {
      return totalSpace! - availableSpace!;
    }
    return null;
  }

  /// Percentual de espaço usado (0.0 a 1.0)
  double? get usedPercentage {
    if (totalSpace != null && availableSpace != null && totalSpace! > 0) {
      return (totalSpace! - availableSpace!) / totalSpace!;
    }
    return null;
  }

  /// Formata bytes para exibição legível
  static String formatBytes(int? bytes) {
    if (bytes == null) return 'Desconhecido';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  @override
  String toString() => 'DiskInfo($name, $mountPoint, $deviceIdentifier)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiskInfo &&
          runtimeType == other.runtimeType &&
          deviceIdentifier == other.deviceIdentifier;

  @override
  int get hashCode => deviceIdentifier.hashCode;
}

/// Status de um teste de verificação de disco.
enum DiskTestStatus {
  /// Teste não iniciado
  pending,
  /// Teste em execução
  running,
  /// Teste concluído com sucesso
  passed,
  /// Teste concluído com avisos
  warning,
  /// Teste falhou
  failed,
  /// Teste pulado ou não suportado
  skipped,
}

/// Representa o resultado de um teste individual de disco.
class DiskTestResult {
  const DiskTestResult({
    required this.testName,
    required this.status,
    this.message,
    this.details,
    this.duration,
  });

  /// Nome do teste
  final String testName;

  /// Status do teste
  final DiskTestStatus status;

  /// Mensagem resumida do resultado
  final String? message;

  /// Detalhes adicionais do teste
  final Map<String, dynamic>? details;

  /// Duração do teste
  final Duration? duration;

  @override
  String toString() => 'DiskTestResult($testName: $status)';
}

/// Representa os resultados completos da verificação de um disco.
class DiskVerificationResult {
  const DiskVerificationResult({
    required this.disk,
    required this.startTime,
    this.endTime,
    this.tests = const [],
    this.overallStatus = DiskTestStatus.pending,
  });

  /// Disco verificado
  final DiskInfo disk;

  /// Hora de início da verificação
  final DateTime startTime;

  /// Hora de término da verificação
  final DateTime? endTime;

  /// Lista de resultados dos testes
  final List<DiskTestResult> tests;

  /// Status geral da verificação
  final DiskTestStatus overallStatus;

  /// Duração total da verificação
  Duration? get totalDuration {
    if (endTime != null) {
      return endTime!.difference(startTime);
    }
    return null;
  }

  /// Cria uma cópia com valores atualizados
  DiskVerificationResult copyWith({
    DiskInfo? disk,
    DateTime? startTime,
    DateTime? endTime,
    List<DiskTestResult>? tests,
    DiskTestStatus? overallStatus,
  }) {
    return DiskVerificationResult(
      disk: disk ?? this.disk,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      tests: tests ?? this.tests,
      overallStatus: overallStatus ?? this.overallStatus,
    );
  }
}
