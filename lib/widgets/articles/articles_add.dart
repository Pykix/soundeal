import 'package:flutter/material.dart';

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  final _titleController = TextEditingController();

  final _stateController = TextEditingController();

  final _ageController = TextEditingController();

  final _typeController = TextEditingController();

  final _priceController = TextEditingController();

  final _descController = TextEditingController();

  String dropdownValue = "Bon";

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
                      value: dropdownValue,
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
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Type'),
                  controller: _typeController,
                  onSubmitted: null,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
