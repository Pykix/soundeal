import 'package:flutter/material.dart';
import '/extension/capitalize_extension.dart';

class CategoryItem extends StatelessWidget {
  final int id;
  final String title;

  CategoryItem(
    this.id,
    this.title,
  );

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed('/articles', arguments: {
      'id': id,
      'title': title,
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
            image: NetworkImage(
                'https://cdn.pixabay.com/photo/2014/10/25/19/24/rape-blossom-502973_960_720.jpg'),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
