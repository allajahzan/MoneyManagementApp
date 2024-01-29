import 'package:hive_flutter/hive_flutter.dart';
part 'model_category.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final bool isDeleted;

  static int categoryID = 0;

  CategoryModel(
      {required this.name, required this.type, this.isDeleted = false}) {
    id = categoryID;
    categoryID++;
  }
}
