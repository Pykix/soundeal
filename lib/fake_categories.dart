import 'package:flutter/material.dart';

import './models/category.dart';

var fakeCategories = [
  Category(
    id: 1,
    type: 'Flûte',
    picture: Image.asset("assets/images/flute.jpg"),
  ),
  Category(
    id: 2,
    type: 'Violon',
    picture: Image.asset("assets/images/violon.jpg"),
  ),
  Category(
    id: 3,
    type: 'Trompette',
    picture: Image.asset("assets/images/trompette.jpg"),
  ),
  Category(
    id: 4,
    type: 'Guitare',
    picture: Image.asset("assets/images/guitare.jpg"),
  ),
  Category(
    id: 5,
    type: 'Batterie',
    picture: Image.asset("assets/images/batterie.jpg"),
  ),
  Category(
    id: 6,
    type: 'Piano',
    picture: Image.asset("assets/images/piano.jpg"),
  ),
];
