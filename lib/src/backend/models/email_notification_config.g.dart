// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_notification_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmailNotificationConfigAdapter
    extends TypeAdapter<EmailNotificationConfig> {
  @override
  final int typeId = 5;

  @override
  EmailNotificationConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmailNotificationConfig(
      isEnabled: fields[0] as bool? ?? false,
      smtpServer: fields[1] as String?,
      smtpPort: fields[2] as int? ?? 587,
      senderEmail: fields[3] as String?,
      senderPassword: fields[4] as String?,
      recipientEmails: (fields[5] as List?)?.cast<String>() ?? const [],
      useSSL: fields[6] as bool? ?? false,
      useTLS: fields[7] as bool? ?? true,
      notifyOnSuccess: fields[8] as bool? ?? true,
      notifyOnFailure: fields[9] as bool? ?? true,
      notifyOnStart: fields[10] as bool? ?? false,
      presetName: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmailNotificationConfig obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.isEnabled)
      ..writeByte(1)
      ..write(obj.smtpServer)
      ..writeByte(2)
      ..write(obj.smtpPort)
      ..writeByte(3)
      ..write(obj.senderEmail)
      ..writeByte(4)
      ..write(obj.senderPassword)
      ..writeByte(5)
      ..write(obj.recipientEmails)
      ..writeByte(6)
      ..write(obj.useSSL)
      ..writeByte(7)
      ..write(obj.useTLS)
      ..writeByte(8)
      ..write(obj.notifyOnSuccess)
      ..writeByte(9)
      ..write(obj.notifyOnFailure)
      ..writeByte(10)
      ..write(obj.notifyOnStart)
      ..writeByte(11)
      ..write(obj.presetName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailNotificationConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
