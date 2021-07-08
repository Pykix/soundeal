import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soundeal/widgets/account/account_screen.dart';
import 'package:soundeal/widgets/authentication/user_secure_storage.dart';
import 'package:soundeal/widgets/bottom_navigation.dart';
import 'package:soundeal/widgets/categories/categories_screen.dart';
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
  final bool created = false;
  String _email = "";
  String _password = "";
  FormType _form = FormType.login;
  bool connected = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    print(index);
    if (_selectedIndex != index) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => CategoriesScreen(),
            ),
            (route) => false);
        break;
      case 1:
        if (!connected) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AccountScreen(),
              ),
              (route) => false);
        }

        break;
    }
  }

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
      bottomNavigationBar: bottomBar(context, _onItemTapped),
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
    if (response.statusCode == 200) {
      Map<String, dynamic> convertedDataToJson = jsonDecode(response.body);
      var token = convertedDataToJson['access_token'];
      var userId = convertedDataToJson['id'];
      print(convertedDataToJson);
      await UserSecureStorage.setJWT(token);
      UserSecureStorage.isConnected = true;
      UserSecureStorage.userId = userId;
      print(UserSecureStorage.userId);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriesScreen(),
          ),
          (route) => false);
    }
    if (response.statusCode == 404) {
      _emailFilter.text = "";
      _passwordFilter.text = "";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Identifiants invalides"),
      ));
    }
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Vous pouvez vous connecter avec vos identifiants"),
    ));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false);
  }

  void _passwordReset() {
    print("Reset du passowrd avec cet email: $_email");
  }
}
