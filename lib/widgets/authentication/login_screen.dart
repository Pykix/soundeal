import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soundeal/main.dart';
import 'package:soundeal/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:soundeal/widgets/authentication/user_secure_storage.dart';
import '../appbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum FormType { login, register }

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  final TextEditingController _usernameFilter = TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType.login;

  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: _emailFilter,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ),
          Container(
            child: TextField(
              controller: _passwordFilter,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
          ),
          _form == FormType.register
              ? Container(
                  child: TextField(
                    controller: _usernameFilter,
                    decoration:
                        InputDecoration(labelText: 'Nom d\'utilisateur'),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Container(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text('Connexion'),
              onPressed: () {
                _loginPressed(_emailFilter.text, _passwordFilter.text);
              },
            ),
            TextButton(
              child: Text('Vous n\'avez pas de compte ? Enregistrez vous.'),
              onPressed: _formChange,
            ),
            TextButton(
              child: Text('Mot de passe oublié ?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text('Creer un compte'),
              onPressed: () {
                _createPressed(_emailFilter.text, _passwordFilter.text,
                    _usernameFilter.text);
              },
            ),
            TextButton(
              child: Text(
                'Vous avez un compte ? Cliquez ici pour vous connecter.',
              ),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
  }

  Future _loginPressed(String email, String password) async {
    final url = Uri.parse('http://10.0.2.2:8000/login');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {"username": _emailFilter.text, "password": _passwordFilter.text},
    );
    Map<String, dynamic> convertedDataToJson = jsonDecode(response.body);
    var token = convertedDataToJson['access_token'];
    await UserSecureStorage.setJWT(token);
    var result = await UserSecureStorage.getJWT();
    print(result);
    return convertedDataToJson;
  }

  Future _createPressed(String email, String password, String username) async {
    final url = Uri.parse('http://10.0.2.2:8000/user/new-user');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": _usernameFilter.text,
        "password": _passwordFilter.text,
        "email": _emailFilter.text
      }),
    );

    var convertedDataToJson = jsonDecode(response.body);
    print(convertedDataToJson);
    return convertedDataToJson;
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}
