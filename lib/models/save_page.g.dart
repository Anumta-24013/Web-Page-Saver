// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedPageAdapter extends TypeAdapter<SavedPage> {
  @override
  final int typeId = 0;

  @override
  SavedPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedPage(
      id: fields[0] as String,
      title: fields[1] as String,
      url: fields[2] as String,
      localPath: fields[3] as String,
      savedDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SavedPage obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.localPath)
      ..writeByte(4)
      ..write(obj.savedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
