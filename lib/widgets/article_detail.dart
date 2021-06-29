import 'package:flutter/material.dart';
import 'package:soundeal/models/articles.dart';
import 'package:soundeal/widgets/appbar.dart';

class ArticleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Articles;
    return Scaffold(
      appBar: appbar(context),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                'https://cdn.pixabay.com/photo/2015/05/07/11/02/guitar-756326_960_720.jpg',
              ),
            ),
          ),
          Text(routeArgs.title),
        ],
      ),
    );
  }
}
