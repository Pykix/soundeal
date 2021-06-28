import 'package:flutter/material.dart';
import 'package:soundeal/category_item.dart';
import './fake_categories.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soundeal"),
      ),
      body: GridView(
        padding: EdgeInsets.all(10),
        children: fakeCategories
            .map(
              (e) => CategoryItem(e.id, e.type, e.picture),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          // childAspectRatio: 3 / 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ),
      ),
    );
  }
}
