import 'dart:convert';

import "package:flutter/material.dart";
import 'package:soundeal/models/articles.dart';
import 'package:soundeal/widgets/authentication/user_secure_storage.dart';
import 'offer_list.dart';
import 'package:http/http.dart' as http;

List<Articles> articlesModelFromJson(String str) =>
    List<Articles>.from(json.decode(str).map((x) => Articles.fromJson(x)));

Future<List<Articles>> fetchArticles() async {
  var userId = UserSecureStorage.userId;
  var response =
      await http.get(Uri.parse('http://10.0.2.2:8000/item/my-item/$userId'));

  if (response.statusCode == 200) {
    print(response.body);
    return articlesModelFromJson(response.body);
  } else {
    throw Exception('Vous n\'avez pas posté d\'annonces!');
  }
}

Future sleep1() {
  return new Future.delayed(const Duration(seconds: 2), () => "2");
}

Future<List<Articles>> deleteArticles(int id) async {
  Future token = UserSecureStorage.getJWT();
  var response = await http.delete(
    Uri.parse('http://10.0.2.2:8000/item/$id'),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await token}"
    },
  );
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
