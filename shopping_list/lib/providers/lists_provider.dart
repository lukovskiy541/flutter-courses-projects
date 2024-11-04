import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/lists.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/models/list_instance.dart';

class ListsNotifier extends Notifier<List<ListInstance>> {
  @override
  List<ListInstance> build() {
    return userLists;
  }

  void addToList(List<ListInstance> list) {}

  void addProduct(GroceryItem item, String listName) {
    final updatedList = [...state];
    final listIndex = updatedList.indexWhere((list) => list.name == listName);
    if (listIndex == -1) {
      return; 
    }
    updatedList[listIndex] = ListInstance(
      name: state[listIndex].name,
      items: [...state[listIndex].items, item],
    );
    state = updatedList;
  }

  void removeProduct(GroceryItem item, String listName) {
    final updatedList = [...state];
    final listIndex = updatedList.indexWhere((list) => list.name == listName);
    if (listIndex == -1) {
      return; 
    }
    updatedList[listIndex] = ListInstance(
        name: state[listIndex].name,
        items: state[listIndex].items.where((p) => p.id != item.id).toList());
    final deletedIndex = updatedList.indexWhere((list) => list.name == 'Deleted');
    updatedList[deletedIndex] = ListInstance(
      name: state[deletedIndex].name,
      items: [...state[deletedIndex].items, item],
    );
    state = updatedList;
  }
}

final listsProvider = NotifierProvider<ListsNotifier, List<ListInstance>>(() {
  return ListsNotifier();
});
