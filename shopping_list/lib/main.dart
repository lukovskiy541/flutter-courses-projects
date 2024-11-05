import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/color.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/models/list_instance.dart';
import 'package:shopping_list/widgets/choose_list.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(ListInstanceAdapter());
  Hive.registerAdapter(GroceryItemAdapter());
  await Hive.openBox<Category>('Categories');
  Hive.registerAdapter(CategoryAdapter());
  runApp(const ProviderScope(child: MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 147, 229, 250),
            brightness: Brightness.dark,
            surface: const Color.fromARGB(
              255,
              42,
              51,
              59,
            ),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60)),
      home: const Lists(),
    );
  }
}
