import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/models/category/model_category.dart';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getDbData();
  Future<void> insertDbData(CategoryModel value);
  Future<void> deleteDbData(int data);
}

class DbFunctions implements CategoryDbFunctions {
  ValueNotifier<List<CategoryModel>> incomeListNotifier = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseListNotifier = ValueNotifier([]);

  DbFunctions.internal();
  static DbFunctions instance = DbFunctions.internal();
  factory DbFunctions() {
    return instance;
  }

  @override
  Future<void> insertDbData(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>("CATEGORY-DATA-BASE");
    await categoryDB.add(value);
    // print(value.id);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getDbData() async {
    final categoryDB = await Hive.openBox<CategoryModel>("CATEGORY-DATA-BASE");
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final fullCategory = await getDbData();

    incomeListNotifier.value.clear();
    expenseListNotifier.value.clear();

    Future.forEach(fullCategory, (CategoryModel category) {
      if (category.type == "income") {
        incomeListNotifier.value.add(category);
      } else {
        expenseListNotifier.value.add(category);
      }
    });
    incomeListNotifier.notifyListeners();
    expenseListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteDbData(int id) async {
    final categoryDB = await Hive.openBox<CategoryModel>("CATEGORY-DATA-BASE");
    categoryDB.delete(id);
    // print(id);
    refreshUI();

    // categoryDB.clear();
    // incomeListNotifier.value.clear();
    // expenseListNotifier.value.clear();
  }
}
