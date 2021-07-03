import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soundeal/models/articles.dart';
import 'package:http/http.dart' as http;
import '../../fake_articles.dart';

Future<Articles> fetchArticles() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/item/29'));

  if (response.statusCode == 200) {
    return Articles.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load articles');
  }
}

class ArticlesList extends StatefulWidget {
  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  Future<Articles> articles;

  @override
  void initState() {
    super.initState();
    articles = fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Articles>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.title);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
        future: articles,
      ),
    );
  }
}
