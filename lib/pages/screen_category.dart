import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/category_db.dart';

import 'package:money_management_app/pages/Screen_expenses.dart';
import 'package:money_management_app/pages/Screen_income.dart';

// ignore: must_be_immutable
class ScreenCategory extends StatefulWidget {
  TabController? tabController;
  ScreenCategory({super.key, this.tabController});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  @override
  void initState() {
    DbFunctions().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.tabController,
      children: const [
        ScreenIncome(),
        ScreenExpenses(),
      ],
    );
  }
}
