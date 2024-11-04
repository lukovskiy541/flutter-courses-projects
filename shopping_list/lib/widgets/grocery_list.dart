import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/providers/lists_provider.dart';
import 'package:shopping_list/widgets/choose_list.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopping_list/models/list_instance.dart';

class GroceryList extends ConsumerStatefulWidget {
  const GroceryList({super.key, required this.name});

  final String name;

  @override
  ConsumerState<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends ConsumerState<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  String _listName = 'Your Groceries';
  var _isLoading = true;
  String? _error;

  void _loaditems() async {
    final url = Uri.https('flutter-prep-cfdc5-default-rtdb.firebaseio.com/',
        'shopping-list.json');

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];
      final List<dynamic> loadedLists = [];

      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value['category'])
            .value;
        final String listName = item.value['listName'];
        final List? foundList =
            loadedLists.firstWhere((list) => list.name == listName);

        if (foundList != null) {
          final List<GroceryItem> loadedItems = [];
          for (dynamic listItem in item.value['items']) {
            loadedItems.add(GroceryItem(
                id: listItem.key,
                name: listItem.value['name'],
                quantity: listItem.value['quantity'],
                category: category));
          }
          loadedLists.add(ListInstance(name: listName, items: []));
        }
      }

      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _error = 'Something went wrong! Please, try later.';
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));
    ref.read(listsProvider.notifier).addProduct(newItem!, _listName);
  }

  void _showLists() async {
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const Lists()));
  }

  void removeItem(GroceryItem item) async {
    ref.read(listsProvider.notifier).removeProduct(item, _listName);
  }

  @override
  Widget build(BuildContext context) {
    final lists = ref.watch(listsProvider);
    _listName = widget.name;
    _groceryItems = lists
        .firstWhere(
          (list) => list.name == widget.name,
          orElse: () => lists[0],
        )
        .items;

    Widget content = const Center(
      child: Text('No items added yet.'),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) {
          if (_listName != 'Deleted') {
            return Dismissible(
              onDismissed: (direction) {
                removeItem(_groceryItems[index]);
              },
              key: ValueKey(_groceryItems[index].id),
              child: ListTile(
                title: Text(
                  _groceryItems[index].name,
                ),
                leading: Container(
                  height: 20,
                  width: 20,
                  color: _groceryItems[index].category.color,
                ),
                trailing: Text(_groceryItems[index].quantity.toString()),
              ),
            );
          } else {
            return ListTile(
              title: Text(
                _groceryItems[index].name,
              ),
              leading: Container(
                height: 20,
                width: 20,
                color: _groceryItems[index].category.color,
              ),
              trailing: Text(_groceryItems[index].quantity.toString()),
            );
          }
        },
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(_listName),
          centerTitle: true,
          leading:
              IconButton(onPressed: _showLists, icon: const Icon(Icons.list)),
          actions: [
            if (_listName != 'Deleted')
              IconButton(onPressed: _addItem, icon: const Icon(Icons.add)),
          ],
        ),
        body: content);
  }
}
