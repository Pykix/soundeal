import "package:flutter/material.dart";
import './categories_screen.dart';

class ArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: Center(
        child: Text('List of articles'),
      ),
    );
  }
}
