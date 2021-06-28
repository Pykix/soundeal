import 'package:flutter/material.dart';
import './articles_screen.dart';

class CategoryItem extends StatelessWidget {
  final int id;
  final String title;
  final Image picture;

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
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: picture.image,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
