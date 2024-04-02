import 'package:flutter/material.dart';
import 'pageJouer.dart';
import 'pageRegle.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'scorePage.dart';


class AccueilPage extends StatelessWidget {
  final Future<Database> database;
  const AccueilPage({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'images/nombreAccueil.jpg', // Chemin de votre image
                width: 600, // Largeur de l'image
                height: 600, // Hauteur de l'image
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PageJoueur(database: database,)),
                    );
                  },
                  child: Text('jouer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BestScoresPage(database :database)),
                    );

                  },
                  child: Text('score'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NumberGuessingGamePage()),
                    );
                  },
                  child: Text('régle'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}


