import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';

import 'package:money_management_app/models/category/model_category.dart';

// ignore: must_be_immutable
class ScreenCategoryAdd extends StatelessWidget {
  ScreenCategoryAdd({super.key});

  ValueNotifier<String> categoryTypeNotifier = ValueNotifier("income");

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Add Categories",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
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
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Card(
                    // color: Colors.white38,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: TextFormField(
                        controller: controller,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter category name",
                            hintStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: categoryTypeNotifier,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.deepPurple),
                                  value: "income",
                                  groupValue: value,
                                  onChanged: (newValue) {
                                    categoryTypeNotifier.value = newValue!;
                                  }),
                              const Text(
                                "Income",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                  fillColor: const MaterialStatePropertyAll(
                                      Colors.deepPurple),
                                  value: "expense",
                                  groupValue: value,
                                  onChanged: (newValue) {
                                    categoryTypeNotifier.value = newValue!;
                                    print(newValue);
                                  }),
                              const Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      onPressed: () {
                        addData(context);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(
                        "ADD",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addData(BuildContext context) async {
    if (controller.text.isEmpty) {
      return;
    } else {
      final sample = CategoryModel(
          name: controller.text, type: categoryTypeNotifier.value);
      DbFunctions().insertDbData(sample);

      controller.clear();
      categoryTypeNotifier.value = "income";
    }
  }
}
