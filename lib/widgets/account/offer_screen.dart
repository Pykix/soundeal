import "package:flutter/material.dart";
import 'package:soundeal/models/articles.dart';
import 'offer_list.dart';
import '../../fake_articles.dart';

class OfferScreen extends StatefulWidget {
  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final List<Articles> _allArticles = articles;

  void _deleteTransaction(int id) {
    setState(() {
      _allArticles.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Annonces"),
      ),
      body: OfferList(_allArticles, _deleteTransaction),
    );
  }
}
