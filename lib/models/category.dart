import 'package:flutter/material.dart';

class Category {
  final int id;
  final String type;

  Category({
    this.id,
    this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      type: json['type'],
    );
  }
}
