import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/db/category/category_db.dart';

import 'package:money_management_app/models/category/model_category.dart';
import 'package:money_management_app/models/transactions/model_transaction.dart';
import 'package:money_management_app/screens/screen_main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final obj1 = DbFunctions();
  final obj2 = DbFunctions();
  print("Object Comparison");
  print(obj1 == obj2);

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.yellow),
      home: const ScreenMain(),
    );
  }
}
