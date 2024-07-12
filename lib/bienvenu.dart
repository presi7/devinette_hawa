import 'package:devine/main.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyAppl());

class MyAppl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,

      home: HomePages(),
    );
  }
}

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Image de fond
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/pinke.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu de la page
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Titre
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                // Bouton
                ElevatedButton(
                  onPressed: () {
                    // Redirection vers MyPage
                    Navigator.push(
                      context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Text('Commencer'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Couleur de fond du bouton
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                    textStyle: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}