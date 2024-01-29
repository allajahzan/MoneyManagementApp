import 'package:hive_flutter/hive_flutter.dart';

part 'model_transaction.g.dart';

@HiveType(typeId: 2)
class TransactionModel {
  @HiveField(0)
  final String purpose;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String type;

  @HiveField(4)
  final String categoryName;

  @HiveField(5)
  int? id;

  static int transactionID = 0;

  TransactionModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.categoryName}) {
    id = transactionID;
    transactionID++;
  }
}
