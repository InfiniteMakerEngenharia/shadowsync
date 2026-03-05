// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telegram_notification_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TelegramNotificationConfigAdapter
    extends TypeAdapter<TelegramNotificationConfig> {
  @override
  final int typeId = 4;

  @override
  TelegramNotificationConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TelegramNotificationConfig(
      isEnabled: fields[0] as bool? ?? false,
      botToken: fields[1] as String?,
      chatId: fields[2] as String?,
      notifyOnSuccess: fields[3] as bool? ?? true,
      notifyOnFailure: fields[4] as bool? ?? true,
      notifyOnStart: fields[5] as bool? ?? false,
    );
  }

  @override
  void write(BinaryWriter writer, TelegramNotificationConfig obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isEnabled)
      ..writeByte(1)
      ..write(obj.botToken)
      ..writeByte(2)
      ..write(obj.chatId)
      ..writeByte(3)
      ..write(obj.notifyOnSuccess)
      ..writeByte(4)
      ..write(obj.notifyOnFailure)
      ..writeByte(5)
      ..write(obj.notifyOnStart);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelegramNotificationConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
