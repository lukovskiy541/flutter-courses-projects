import 'package:hive/hive.dart';
import './grocery_item.dart';

part 'list_instance.g.dart';

@HiveType(typeId: 0)
class ListInstance extends HiveObject{
  ListInstance({
    required this.name,
    required this.items,
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<GroceryItem> items;

}