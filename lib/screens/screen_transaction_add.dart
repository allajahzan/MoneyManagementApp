import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';
import 'package:money_management_app/db/transactions/transaction_db.dart';
import 'package:money_management_app/models/category/model_category.dart';
import 'package:money_management_app/models/transactions/model_transaction.dart';

// ignore: must_be_immutable
class ScreenTransactionAdd extends StatefulWidget {
  ScreenTransactionAdd({super.key});

  @override
  State<ScreenTransactionAdd> createState() => _ScreenTransactionAddState();
}

class _ScreenTransactionAddState extends State<ScreenTransactionAdd> {
  ValueNotifier<String> CategoryTypeNotifier = ValueNotifier("income");

  bool? categoryBool = true;

  int? categoryItemID;

  CategoryModel? selectedCategoryModel;

  ValueNotifier<DateTime> selectdDateNotifier = ValueNotifier(DateTime.now());
  String DateTimeString = "Select a date";
  bool dateSelected = false;

  TextEditingController purpose = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Add Transactions",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        children: [
          Card(
            elevation: 15,
            margin: const EdgeInsets.all(20),
            color: const Color.fromARGB(255, 234, 232, 232),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Purpose textform
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: purpose,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Purpose",
                          hintStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Amount textfrom
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Amount",
                          hintStyle: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // calender date picker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: selectdDateNotifier,
                        builder: (context, value, child) {
                          return ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple),
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .subtract(const Duration(days: 30)),
                                  lastDate: DateTime.now());

                              if (selectedDate == null) {
                                return;
                              } else {
                                selectdDateNotifier.value = selectedDate;
                                setState(() {
                                  dateSelected = true;
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today),
                            label: Text(dateSelected
                                ? selectdDateNotifier.value.toString()
                                : DateTimeString),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // radio buttons
                  ValueListenableBuilder(
                    valueListenable: CategoryTypeNotifier,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Radio(
                                fillColor: const MaterialStatePropertyAll(
                                    Colors.deepPurple),
                                value: "income",
                                groupValue: value,
                                onChanged: (newValue) {
                                  CategoryTypeNotifier.value = newValue!;
                                  setState(() {
                                    categoryBool = true;
                                    categoryItemID = null;
                                  });
                                },
                              ),
                              const Text("Income"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                fillColor: const MaterialStatePropertyAll(
                                    Colors.deepPurple),
                                value: "expense",
                                groupValue: value,
                                onChanged: (newValue) {
                                  CategoryTypeNotifier.value = newValue!;
                                  setState(() {
                                    categoryBool = false;
                                    categoryItemID = null;
                                  });
                                },
                              ),
                              const Text("Expense"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // dropdowm list
                  DropdownButton<int>(
                    value: categoryItemID,
                    hint: const Text(
                      "Select Category Name ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: categoryBool!
                        ? DbFunctions().incomeListNotifier.value.map((e) {
                            return DropdownMenuItem<int>(
                              onTap: () {
                                selectedCategoryModel = e;
                              },
                              value: e.id,
                              child: Text(
                                e.name,
                                style: const TextStyle(),
                              ),
                            );
                          }).toList()
                        : DbFunctions().expenseListNotifier.value.map((e) {
                            return DropdownMenuItem<int>(
                              onTap: () {
                                selectedCategoryModel = e;
                              },
                              value: e.id,
                              child: Text(
                                e.name,
                                style: const TextStyle(),
                              ),
                            );
                          }).toList(),
                    onChanged: (value) {
                      setState(() {
                        categoryItemID = value;
                      });
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // submit button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      insertDb();
                    },
                    label: const Text(
                      "SUBMIT",
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> insertDb() async {
    if (purpose.text.isEmpty ||
        amount.text.isEmpty ||
        dateSelected == false ||
        categoryItemID == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromARGB(255, 235, 232, 232),
          content: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Fill all details",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.warning,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      );
    } else {
      double amountDouble = double.parse(amount.text);

      final sample = TransactionModel(
        purpose: purpose.text,
        amount: amountDouble,
        date: selectdDateNotifier.value,
        type: CategoryTypeNotifier.value,
        categoryName: selectedCategoryModel!.name,
      );

      TDbfunctions().inserDbData(sample);

      purpose.clear();
      amount.clear();
      setState(() {
        dateSelected = false;
        categoryItemID = null;
        categoryBool = true;
      });
      CategoryTypeNotifier.value = "income";
    }
  }
}
