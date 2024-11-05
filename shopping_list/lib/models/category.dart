import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

@HiveType(typeId: 2)
class Category extends HiveObject{

  Category(this.title, this.color);
  @HiveField(0)
  final String title;
  @HiveField(1)
  final Color color;
}
