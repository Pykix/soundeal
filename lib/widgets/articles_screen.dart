import "package:flutter/material.dart";

class ArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final titleArg = routeArgs['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text(titleArg),
      ),
      body: Center(
        child: Text('Liste des annonces de ${routeArgs['title']}s'),
      ),
    );
  }
}
