import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/models/list_instance.dart';

final userLists = [
  ListInstance(items: [
    
    GroceryItem(
      id: '2',
      name: 'Bread',
      quantity: 2,
      category: categories[Categories.carbs]!,
    ),
    GroceryItem(
      id: '3',
      name: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!,
    ),
    GroceryItem(
      id: '4',
      name: 'Eggs',
      quantity: 12,
      category: categories[Categories.dairy]!,
    ),
    GroceryItem(
      id: '5',
      name: 'Carrots',
      quantity: 4,
      category: categories[Categories.vegetables]!,
    ),
  ], name: 'Everyday products'),
  ListInstance(items: [
    GroceryItem(
      id: '1',
      name: 'Apples',
      quantity: 5,
      category: categories[Categories.fruit]!,
    ),
    
  ], name: 'Deleted'),
];
