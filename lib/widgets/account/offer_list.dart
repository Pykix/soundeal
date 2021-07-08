import 'package:flutter/material.dart';
import 'package:soundeal/models/articles.dart';

class OfferList extends StatelessWidget {
  AsyncSnapshot<dynamic> articles;
  final Function deleteArticle;
  OfferList(
    this.articles,
    this.deleteArticle,
  );
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.data.length,
      itemBuilder: (context, index) {
        var article = articles.data[index];
        return Card(
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
              article.title,
            ),
            subtitle: Text("${article.price.toString()}€"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                print(article.id);
                deleteArticle(article.id);
              },
            ),
          ),
        );
      },
    );
  }
}
