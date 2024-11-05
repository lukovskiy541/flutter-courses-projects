
import 'package:shopping_list/models/category.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'grocery_item.g.dart';

@HiveType(typeId: 1) 
class GroceryItem extends HiveObject{
  GroceryItem({ required this.id,required this.name,required this.quantity,required this.category});
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int quantity;
  @HiveField(3)
  final Category category;
}




