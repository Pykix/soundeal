import 'package:flutter/material.dart';

import '../fake_articles.dart';

class ArticlesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 8,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text('${articles[index].price}€'),
                ),
              ),
            ),
            title: Text(
              articles[index].title,
            ),
            subtitle: Text(articles[index].desc),
          ),
        );
      },
      itemCount: articles.length,
    );
  }
}
