import 'package:flutter/material.dart';

class Category {
  final int id;
  final String type;
  final String picture;

  Category({this.id, this.type, this.picture});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      type: json['type'],
      picture: json['picture'],
    );
  }
}
