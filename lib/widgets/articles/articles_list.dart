import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soundeal/models/articles.dart';
import 'package:http/http.dart' as http;

List<Articles> articlesModelFromJson(String str) =>
    List<Articles>.from(json.decode(str).map((x) => Articles.fromJson(x)));

Future<List<Articles>> fetchArticles(int id) async {
  var response =
      await http.get(Uri.parse('http://10.0.2.2:8000/item/category/$id'));

  if (response.statusCode == 200) {
    return articlesModelFromJson(response.body);
  } else {
    throw Exception('Failed to load articles');
  }
}

class ArticlesList extends StatefulWidget {
  final int id;
  ArticlesList(this.id);
  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  Future<List<Articles>> articlesObject;

  final snackbar = SnackBar(
    content: Text('Vous etes maintenant connecté'),
  );
  @override
  void initState() {
    super.initState();
    articlesObject = fetchArticles(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: articlesObject,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Text("${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var article = snapshot.data[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: Articles(
                          id: article.id,
                          title: article.title,
                          description: article.description,
                          state: article.state,
                          price: article.price,
                          age: article.age,
                          type: article.type,
                          user: article.user,
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
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
                            article.title,
                          ),
                          subtitle: Text(
                            article.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text("${article.price.toString()}€"),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
