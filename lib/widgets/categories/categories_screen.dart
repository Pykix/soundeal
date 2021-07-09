import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soundeal/models/category.dart';
import 'package:soundeal/widgets/articles/articles_add.dart';
import 'package:soundeal/widgets/authentication/login_screen.dart';
import 'package:soundeal/widgets/authentication/user_secure_storage.dart';
import 'package:soundeal/widgets/bottom_navigation.dart';
import '../appbar.dart';
import 'package:http/http.dart' as http;
import '../categories/category_item.dart';

import '../account/account_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Future categories;
  bool connected;
  int _selectedIndex = 0;
  bool isConnected = false;
  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
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
        if (!connected) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AccountScreen(),
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
  void initState() {
    super.initState();
    categories = fetchCategories();
    connected = UserSecureStorage.isConnected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: FutureBuilder<List<Category>>(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  // childAspectRatio: 3 / 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                ),
                itemBuilder: (context, index) {
                  return CategoryItem(
                    snapshot.data[index].id,
                    snapshot.data[index].type,
                    snapshot.data[index].picture,
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Error : ${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: bottomBar(context, _onItemTapped),
      floatingActionButton: connected
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewOffer(context),
            )
          : Container(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  List<Category> categoriesModelFromJson(String str) =>
      List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

  Future<List<Category>> fetchCategories() async {
    var response =
        await http.get(Uri.parse('http://10.0.2.2:8000/item/category'));

    if (response.statusCode == 200) {
      return categoriesModelFromJson(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
