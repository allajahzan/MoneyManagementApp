import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transactions/transaction_db.dart';

class ScreenIncome extends StatelessWidget {
  const ScreenIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: ValueListenableBuilder(
        valueListenable: DbFunctions().incomeListNotifier,
        builder: (context, value, child) {
          return ListView.separated(
            padding: const EdgeInsets.all(15),
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 4,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      value[index].name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          DbFunctions().deleteDbData(value[index].id!);
                          TDbfunctions().deletePerticularTypeTransactions(
                              value[index].name);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 15,
              );
            },
            itemCount: value.length,
          );
        },
      ),
    );
  }
}
