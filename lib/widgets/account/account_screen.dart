import "package:flutter/material.dart";
import 'package:soundeal/widgets/authentication/user_secure_storage.dart';
import 'package:soundeal/widgets/bottom_navigation.dart';
import 'package:soundeal/widgets/categories/categories_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool connected = UserSecureStorage.isConnected;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      return;
    }
    setState(() {
      _selectedIndex = index;
      connected = UserSecureStorage.isConnected;
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
      appBar: AppBar(
        title: Text("Mon compte"),
      ),
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(
            title: Text("Mes annonces"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, '/myoffers');
            },
          ),
          ListTile(
            title: Text("Mes Infos"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: Text("Deconnexion"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              if (connected) {
                UserSecureStorage.isConnected = false;
                print(UserSecureStorage.isConnected);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Vous etes deconnecté'),
                  ),
                );
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoriesScreen(),
                    ),
                    (route) => false);
              }
            },
          ),
        ],
      )),
      bottomNavigationBar: bottomBar(context, _onItemTapped),
    );
  }
}
