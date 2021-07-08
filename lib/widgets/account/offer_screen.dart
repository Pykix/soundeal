import 'dart:convert';

import "package:flutter/material.dart";
import 'package:soundeal/models/articles.dart';
import 'offer_list.dart';
import 'package:http/http.dart' as http;

List<Articles> articlesModelFromJson(String str) =>
    List<Articles>.from(json.decode(str).map((x) => Articles.fromJson(x)));

Future<List<Articles>> fetchArticles() async {
  var response =
      await http.get(Uri.parse('http://10.0.2.2:8000/item/my-item/1'));

  if (response.statusCode == 200) {
    return articlesModelFromJson(response.body);
  } else {
    throw Exception('Failed to load articles');
  }
}

Future<List<Articles>> deleteArticles(int id) async {
  var response = await http.delete(
    Uri.parse('http://10.0.2.2:8000/item/$id'),
  );

  if (response.statusCode == 200) {
    return articlesModelFromJson(response.body);
  } else {
    throw Exception('Failed to load articles');
  }
}

class OfferScreen extends StatefulWidget {
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  Future<List<Articles>> _allArticles;
  @override
  void initState() {
    super.initState();
    _allArticles = fetchArticles();
  }

  void _deleteTransaction(int id) {
    setState(
      () {
        deleteArticles(id);
        _allArticles = fetchArticles();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Annonces"),
      ),
      body: FutureBuilder(
        future: _allArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Text("${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return OfferList(snapshot, _deleteTransaction);
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
