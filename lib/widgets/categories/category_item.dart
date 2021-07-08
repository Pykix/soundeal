import 'package:flutter/material.dart';
import '/extension/capitalize_extension.dart';

class CategoryItem extends StatelessWidget {
  final int id;
  final String title;
  final String picture;

  CategoryItem(
    this.id,
    this.title,
    this.picture,
  );

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed('/articles', arguments: {
      'id': id,
      'title': title,
      'picture': picture,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title.capitalize(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage("http://10.0.2.2:8000/" + picture),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
