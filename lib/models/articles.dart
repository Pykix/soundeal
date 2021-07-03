import 'package:flutter/material.dart';

class Articles {
  final int id;
  final String title;
  final String description;
  final String state;
  final int price;
  final int age;
  final int type;
  final int user;

  Articles({
    this.id,
    this.title,
    this.description,
    this.state,
    this.price,
    this.age,
    this.type,
    this.user,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      state: json['state'],
      price: json['price'],
      age: json['age'],
      type: json['type_id'],
      user: json['user_id'],
    );
  }
}
