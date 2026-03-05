import 'package:hive_flutter/hive_flutter.dart';

part 'user_settings.g.dart';

/// Configurações do usuário persistidas localmente.
@HiveType(typeId: 2)
class UserSettings extends HiveObject {
  UserSettings({
    this.userName,
    this.avatarPath,
    this.encryptionPassword,
    this.useCustomBackupName = false,
    this.customBackupName,
  });

  /// Nome do usuário
  @HiveField(0)
  String? userName;

  /// Caminho local da imagem do avatar
  @HiveField(1)
  String? avatarPath;

  /// Senha usada para criptografia dos backups
  @HiveField(2)
  String? encryptionPassword;

  /// Se deve usar nome personalizado para os arquivos de backup
  @HiveField(3)
  bool useCustomBackupName;

  /// Nome personalizado para os arquivos de backup
  @HiveField(4)
  String? customBackupName;

  /// Cria uma cópia com os campos atualizados
  UserSettings copyWith({
    String? userName,
    String? avatarPath,
    String? encryptionPassword,
    bool? useCustomBackupName,
    String? customBackupName,
  }) {
    return UserSettings(
      userName: userName ?? this.userName,
      avatarPath: avatarPath ?? this.avatarPath,
      encryptionPassword: encryptionPassword ?? this.encryptionPassword,
      useCustomBackupName: useCustomBackupName ?? this.useCustomBackupName,
      customBackupName: customBackupName ?? this.customBackupName,
    );
  }

  /// Retorna as iniciais do nome do usuário
  String getInitials() {
    if (userName == null || userName!.isEmpty) return 'U';
    final parts = userName!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }
}
