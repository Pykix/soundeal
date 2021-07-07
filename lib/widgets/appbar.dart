import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

Widget appbar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: const Text("Soundeal"),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(25),
      ),
    ),
    // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))],
  );
}
