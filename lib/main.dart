import 'package:flutter/material.dart';
import 'package:soundeal/widgets/account/account_screen.dart';
import 'package:soundeal/widgets/account/offer_screen.dart';
import 'package:soundeal/widgets/articles/article_detail.dart';
import 'widgets/articles/articles_screen.dart';
import 'widgets/categories/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        canvasColor: Color.fromRGBO(255, 254, 255, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline3: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
      ),
      title: "Soundeal",
      home: CategoriesScreen(),
      routes: {
        '/articles': (context) => ArticlesScreen(),
        '/compte': (context) => AccountScreen(),
        '/categories': (context) => CategoriesScreen(),
        '/detail': (context) => ArticleDetail(),
        '/myoffers': (context) => OfferScreen(),
      },
    );
  }
}
