import 'package:flutter/material.dart';

class Articles {
  final int id;
  final String title;
  final String desc;
  final String state;
  final int price;
  final int age;
  final String type;
  final String user;
  final Image picture;

  Articles(
    this.id,
    this.title,
    this.desc,
    this.state,
    this.price,
    this.age,
    this.type,
    this.user,
    this.picture,
  );
}
