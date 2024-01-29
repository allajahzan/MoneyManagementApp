import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transactions/transaction_db.dart';
import 'package:intl/intl.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TDbfunctions().refreshUI();
    DbFunctions().refreshUI();
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: TDbfunctions().transactionListNotifier,
          builder: (context, value, child) {
            return ListView.separated(
              padding: const EdgeInsets.all(15),
              itemBuilder: (ctx, index) {
                return Slidable(
                  key: Key(value[index].id.toString()),
                  // dragStartBehavior: DragStartBehavior.down,
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (BuildContext context) {
                          TDbfunctions().deleteDbData(value[index].id!);
                        },
                        icon: Icons.delete,
                        label: "Delete",
                      )
                    ],
                  ),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 121, 80, 193),
                          radius: 30,
                          child: Text(
                            parseDate(value[index].date),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        title: Text(
                          "Rs ${value[index].amount}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          value[index].categoryName,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        trailing: value[index].type == "income"
                            ? const CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    Color.fromARGB(255, 244, 240, 240),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 25,
                                ),
                              )
                            : const CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    Color.fromARGB(255, 244, 240, 240),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                  size: 25,
                                ),
                              ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 11,
                );
              },
              itemCount: value.length,
            );
          },
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    final dateformat = DateFormat.MMMd();
    final newFormat = dateformat.format(date);

    final splitted = newFormat.split(" ");

    final mon = splitted[0].toUpperCase();
    final day = splitted[1];

    return "$day\n$mon";
  }
}
