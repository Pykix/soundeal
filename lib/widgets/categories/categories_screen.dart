import 'package:flutter/material.dart';
import 'package:soundeal/widgets/bottom_navigation.dart';
import '../appbar.dart';
import '../categories/category_item.dart';
import '../../fake_categories.dart';
import '../account_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CategoriesScreen(),
            ),
            (route) => false);
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AccountScreen(),
            ),
            (route) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: GridView(
        padding: EdgeInsets.all(10),
        children: fakeCategories
            .map(
              (e) => CategoryItem(e.id, e.type, e.picture),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          // childAspectRatio: 3 / 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
      ),
      bottomNavigationBar: bottomBar(context, _onItemTapped),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
