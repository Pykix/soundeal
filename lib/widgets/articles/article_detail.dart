import 'package:flutter/material.dart';
import 'package:soundeal/models/articles.dart';
import 'package:soundeal/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context).settings.arguments as Articles;
    final String mail =
        "mailto:nation.addict@gmail.com?subject=${article.title}&body=Bonjour, votre annonce m'interresse est-elle toujours dispo?";
    return Scaffold(
      appBar: appbar(context),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            padding: EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                'https://cdn.pixabay.com/photo/2015/05/07/11/02/guitar-756326_960_720.jpg',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Row(
              children: <Widget>[
                Text("etat: ${article.state}"),
                Spacer(),
                Text("type:  ${article.type}"),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Row(
              children: <Widget>[
                Text("age: ${article.age}"),
                Spacer(),
                Text("type:  ${article.price}€"),
              ],
            ),
          ),
          Divider(),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc pellentesque mi vitae turpis pretium, ut feugiat dui scelerisque. Duis dapibus massa diam. Nunc venenatis lacinia massa, vitae luctus ligula facilisis vitae. Nunc scelerisque consequat urna, in accumsan nisi tempor suscipit. Phasellus elementum sollicitudin scelerisque. Nam et blandit risus, accumsan varius massa. Fusce condimentum id est eu ultricies. Fusce molestie nec sapien et posuere. Vestibulum non justo quis est porttitor tempus. Nunc in nibh a felis scelerisque aliquet.",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => launch(mail),
                  child: Icon(Icons.email, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Theme.of(context).primaryColor, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                  ),
                ),
                ElevatedButton(
                  onPressed: () => launch("tel:+33101010101"),
                  child: Icon(Icons.phone, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Theme.of(context).primaryColor, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                  ),
                ),
                ElevatedButton(
                  onPressed: () => launch("sms:+33101010101"),
                  child: Icon(Icons.message, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Theme.of(context).primaryColor, // <-- Button color
                    onPrimary: Colors.red, // <-- Splash color
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
