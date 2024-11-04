import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/models/list_instance.dart';
import 'package:shopping_list/providers/lists_provider.dart';
import 'package:shopping_list/widgets/grocery_list.dart';
import 'package:shopping_list/widgets/new_list.dart';

class Lists extends ConsumerStatefulWidget {
  const Lists({super.key});

  @override
  ConsumerState<Lists> createState() => _ListsState();
}

class _ListsState extends ConsumerState<Lists> {

  void _addList() async {
    final newItem = await Navigator.of(context).push<ListInstance>(
        MaterialPageRoute(builder: (ctx) => const NewList()));
    ref.read(listsProvider.notifier).addlist(newItem!);
  }

  @override
  Widget build(BuildContext context) {
    final lists = ref.watch(listsProvider).where((p) => p.name != 'Deleted').toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lists'),
        centerTitle: true,
        actions: [
          IconButton(onPressed:_addList
          , icon: const Icon(Icons.add)),
          IconButton(onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const GroceryList(name: 'Deleted',)));
          }, icon: const Icon(Icons.delete)),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(
                  lists[index].name
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => GroceryList(name: lists[index].name,)));
                },
                );
          },
          itemCount: lists.length,
        ),
      ),
    );
  }
}
