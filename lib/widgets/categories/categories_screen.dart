import 'package:flutter/material.dart';
import 'package:soundeal/widgets/articles/articles_add.dart';
import 'package:soundeal/widgets/authentication/login_screen.dart';
import 'package:soundeal/widgets/bottom_navigation.dart';
import '../appbar.dart';
import '../categories/category_item.dart';
import '../../fake_categories.dart';
import '../account/account_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedIndex = 0;
  bool isConnected = false;
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
        if (!isConnected) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        }

        break;
    }
  }

  void _startAddNewOffer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: AddArticle(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
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
        onPressed: () => _startAddNewOffer(context),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
