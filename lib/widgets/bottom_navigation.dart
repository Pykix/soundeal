import 'package:flutter/material.dart';

Widget bottomBar(BuildContext context, itemTaped) {
  return BottomNavigationBar(
    onTap: itemTaped,
    type: BottomNavigationBarType.fixed,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.category),
        label: 'Categories',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Compte',
      ),
    ],
  );
}
