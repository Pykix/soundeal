import "package:flutter/material.dart";
import 'package:soundeal/widgets/bottom_navigation.dart';
import 'package:soundeal/widgets/categories_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
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
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Account page"),
      ),
      body: Center(
        child: Text('Votre page de compte'),
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
