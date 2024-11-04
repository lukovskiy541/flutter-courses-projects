import 'package:shopping_list/models/grocery_item.dart';

class ListInstance {
  ListInstance({ required this.name,required this.items});

  List<GroceryItem> items = [];
  final String name;
}
