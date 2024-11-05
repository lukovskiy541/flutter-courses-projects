import 'package:hive/hive.dart';
import 'package:flutter/material.dart';



class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 3;

  @override
  Color read(BinaryReader reader) {
    final value = reader.readUint32();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color color) {
    writer.writeUint32(color.value);
  }
}
