import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management_app/models/transactions/model_transaction.dart';

abstract class TransactionDbFunctions {
  Future<List<TransactionModel>> getDbData();
  Future<void> inserDbData(TransactionModel value);
  Future<void> deleteDbData(int id);
  Future<void> deletePerticularTypeTransactions(String name);
}

class TDbfunctions implements TransactionDbFunctions {
  TDbfunctions.internal();
  static TDbfunctions instence = TDbfunctions.internal();
  factory TDbfunctions() {
    return instence;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  ValueNotifier<List<TransactionModel>> incomesNotifier = ValueNotifier([]);

  ValueNotifier<List<TransactionModel>> expenseNotifier = ValueNotifier([]);

  @override
  Future<void> inserDbData(TransactionModel value) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>("TRANSACTION-DATA-BASE");
    transactionDB.add(value);
    // print(value.id);
    refreshUI();
  }

  @override
  Future<List<TransactionModel>> getDbData() async {
    final transactionDB =
        await Hive.openBox<TransactionModel>("TRANSACTION-DATA-BASE");
    return transactionDB.values.toList();
  }

  Future<void> refreshUI() async {
    final transactionLists = await getDbData();

    transactionLists.sort(
      (a, b) {
        return b.date.compareTo(a.date);
      },
    );

    transactionListNotifier.value.clear();
    incomesNotifier.value.clear();
    expenseNotifier.value.clear();

    transactionListNotifier.value.addAll(transactionLists);

    await Future.forEach(transactionLists, (TransactionModel transaction) {
      if (transaction.type == "income") {
        incomesNotifier.value.add(transaction);
      } else {
        expenseNotifier.value.add(transaction);
      }
    });

    incomesNotifier.notifyListeners();
    expenseNotifier.notifyListeners();
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteDbData(int id) async {
    final transactionDB =
        await Hive.openBox<TransactionModel>("TRANSACTION-DATA-BASE");

    transactionDB.delete(id);
    refreshUI();
  }

  @override
  Future<void> deletePerticularTypeTransactions(String name) async {
    final transactionLists = await getDbData();
    final transactionDB =
        await Hive.openBox<TransactionModel>("TRANSACTION-DATA-BASE");

    Future.forEach(transactionLists, (TransactionModel transaction) {
      if (transaction.categoryName == name) {
        final data = transaction;
        final id = data.id;
        transactionDB.delete(id);
      }
    });
    refreshUI();

    // transactionDB.clear();
    // transactionListNotifier.value.clear();
  }
}
