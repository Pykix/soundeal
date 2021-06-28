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
    Navigator.of(context).pushNamed('/categories', arguments: {
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
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: <Widget>[
            Image(
              image: (picture.image),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
