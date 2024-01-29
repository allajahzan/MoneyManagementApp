import 'package:flutter/material.dart';
import 'package:money_management_app/pages/page_onlyexpenses.dart';
import 'package:money_management_app/pages/page_onlyincomes.dart';
import 'package:money_management_app/pages/screen_category.dart';
import 'package:money_management_app/pages/screen_transaction.dart';
import 'package:money_management_app/screens/screen_category_add.dart';
import 'package:money_management_app/screens/screen_transaction_add.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain>
    with SingleTickerProviderStateMixin {
  int index = 0;

  bool categoryPage = false;

  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      ScreenTransaction(),
      ScreenCategory(
        tabController: tabController,
      ),
    ];
    // changeAppBar();
    return Scaffold(
      appBar: categoryPage
          ? AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text(
                "Money Manager",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              bottom: TabBar(
                onTap: (value) {},
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                indicatorWeight: 4,
                controller: tabController,
                tabs: const [
                  Tab(
                    text: "INCOMES",
                  ),
                  Tab(
                    text: "EXPENSES",
                  ),
                ],
              ),
            )
          : AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text(
                "Money Manager",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "incomes") {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext ctx) {
                        return const PageIncomesOnly();
                      }));
                    } else {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext ctx) {
                        return const PageExpensesOnly();
                      }));
                    }
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: "incomes",
                        child: Text(
                          "Incomes",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const PopupMenuItem(
                        value: "expense",
                        child: Text(
                          "Expenses",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ];
                  },
                )
              ],
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            if (index == 0) {
              // print("add transaction");
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ScreenTransactionAdd();
              }));
            } else {
              // print("Add category");
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return ScreenCategoryAdd();
              }));
            }
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      bottomSheet: BottomNavigationBar(
        onTap: (value) {
          // changeAppBar();
          setState(() {
            index = value;
            if (index == 0) {
              categoryPage = false;
            } else {
              categoryPage = true;
            }
          });
        },
        currentIndex: index,
        elevation: 20,
        selectedItemColor: Colors.deepPurple,
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 30),
        unselectedFontSize: 14,
        selectedFontSize: 14,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        items: const [
          BottomNavigationBarItem(
            label: "Transaction",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Categaory",
            icon: Icon(
              Icons.category,
            ),
          ),
        ],
      ),
      body: pages[index],
    );
  }
}
