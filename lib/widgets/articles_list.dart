import 'package:flutter/material.dart';
import 'package:soundeal/models/articles.dart';

import '../fake_articles.dart';

class ArticlesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print(articles[index]);
            Navigator.pushNamed(
              context,
              '/detail',
              arguments: {
                'detailTitle': articles[index].title,
              },
            );
          },
          child: Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 8,
            ),
            child: ListTile(
              leading: ClipRRect(
                child: Image.network(
                  'https://cdn.pixabay.com/photo/2021/06/17/05/14/city-6342765_960_720.jpg',
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              title: Text(
                articles[index].title,
              ),
              subtitle: Text(articles[index].desc),
              trailing: Text("${articles[index].price.toString()}€"),
            ),
          ),
        );
      },
      itemCount: articles.length,
    );
  }
}
