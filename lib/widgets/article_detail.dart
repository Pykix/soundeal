import 'package:flutter/material.dart';
import 'package:soundeal/models/articles.dart';

class ArticleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final title = routeArgs['detailTitle'];
    print(title);
    return Column(
      children: <Widget>[
        Image.network(
          'https://cdn.pixabay.com/photo/2015/05/07/11/02/guitar-756326_960_720.jpg',
        ),
        Text(title)
      ],
    );
  }
}
