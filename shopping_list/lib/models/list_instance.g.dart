// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_instance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListInstanceAdapter extends TypeAdapter<ListInstance> {
  @override
  final int typeId = 0;

  @override
  ListInstance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListInstance(
      name: fields[0] as String,
      items: (fields[1] as List).cast<GroceryItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListInstance obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListInstanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
