import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list/data/lists.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/models/list_instance.dart';

class ListsNotifier extends Notifier<List<ListInstance>> {
  ListsNotifier() {
    init();
  }
  final String _boxName = "Lists";
  bool _isInitialized = false;

  Future<Box<List<dynamic>>> get _box async =>
      Hive.openBox<List<dynamic>>(_boxName);

  Future<void> initializeLists() async {
    var box = await _box;
    if (!box.containsKey('lists')) {
      await box.put('lists', userLists);
    }
    final data = box.get('lists');
    List<ListInstance> lists = [];
    print(data.runtimeType);

    for (final i in data!) {
      lists.add(i);
    }

    state = lists;
    _isInitialized = true;
  }

  void init() async {
    await initializeLists();
  }

  @override
  List<ListInstance> build() {
    if (!_isInitialized) {
      return [];
    }
    return state;
  }

  void addToList(List<ListInstance> list) {}

  void addProduct(GroceryItem item, String listName) async {
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
    var box = await _box;
    box.put('lists', updatedList);
  }

  void addlist(ListInstance item) async {
    state = [...state, item];
    var box = await _box;
    box.put('lists', state);
  }

  void removeProduct(GroceryItem item, String listName) async {
    final updatedList = [...state];
    final listIndex = updatedList.indexWhere((list) => list.name == listName);
    if (listIndex == -1) {
      return;
    }
    updatedList[listIndex] = ListInstance(
        name: state[listIndex].name,
        items: state[listIndex].items.where((p) => p.id != item.id).toList());
    final deletedIndex =
        updatedList.indexWhere((list) => list.name == 'Deleted');
    updatedList[deletedIndex] = ListInstance(
      name: state[deletedIndex].name,
      items: [...state[deletedIndex].items, item],
    );
    state = updatedList;
    var box = await _box;
    box.put('lists', updatedList);
  }
}

final listsProvider = NotifierProvider<ListsNotifier, List<ListInstance>>(() {
  return ListsNotifier();
});
