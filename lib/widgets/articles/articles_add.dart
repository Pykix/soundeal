import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  final _titleController = TextEditingController();

  final _ageController = TextEditingController();

  final _typeController = TextEditingController();

  final _priceController = TextEditingController();

  final _descController = TextEditingController();

  String _stateValue = "Bon";
  String _typeValue = "Flute";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Titre'),
                  controller: _titleController,
                  onSubmitted: null,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Age'),
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  onSubmitted: null,
                ),
                Row(
                  children: [
                    Text("Etat"),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButton(
                      value: _stateValue,
                      items: <String>[
                        "Neuf",
                        "Tres Bon",
                        "Bon",
                        "Usure legere",
                        "Mauvais"
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _stateValue = newValue;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Type"),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButton(
                      value: _typeValue,
                      items: <String>[
                        "Flute",
                        "Violon",
                        "Trompette",
                        "Guitare",
                        "Batterie",
                        "Piano",
                        "Micro",
                        "Platine",
                        "Electrique",
                        "Saxo",
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _typeValue = newValue;
                        });
                      },
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Prix'),
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  onSubmitted: null,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Descrption'),
                  controller: _descController,
                  onSubmitted: null,
                ),
                ElevatedButton(
                  onPressed: () {
                    _addItem(
                        _titleController.text,
                        _ageController.text,
                        _stateValue,
                        _priceController.text,
                        _descController.text);
                    Navigator.pop(context);
                  },
                  child: Text("Ajouter"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _addItem(
      String title, String age, String state, String price, String desc) async {
    final data = {
      "title": title,
      "age": int.parse(age),
      "description": desc,
      "state": state,
      "price": int.parse(price),
      "user_id": 1,
      "type_id": 21
    };
    final url = Uri.parse('http://10.0.2.2:8000/item/');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(
          {
            "title": title,
            "description": desc,
            "state": state,
            "price": int.parse(price),
            "age": int.parse(age),
            "user_id": 1,
            "type_id": 21
          },
        ),
      );
      if (response.statusCode == 201) {
        print(response.body);
        return json.decode(response.body);
      } else {
        print(response.body);
      }
    } catch (e) {
      return print(e);
    }
  }
}
