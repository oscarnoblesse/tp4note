import 'package:flutter/material.dart';
import 'pageJouer.dart';
import 'pageRegle.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'scorePage.dart';
import 'historiqueJoeur.dart';


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
                    _showAddScoreDialog(context);
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
                    _showAddScoreDialogHistorique(context);
                  },
                  child: Text('historique'),
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

  Future<void> _showAddScoreDialog(BuildContext context) async {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un score'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Prénom'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Ajouter'),
              onPressed: () {
                String name = _nameController.text;
                String lastName = _lastNameController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageJoueur(database: database,nom: name,prenom: lastName)),
                );

              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddScoreDialogHistorique(BuildContext context) async {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter un score'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Prénom'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Ajouter'),
              onPressed: () {
                String name = _nameController.text;
                String lastName = _lastNameController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => historiqueScoresPage(database: database,nom: name,prenom: lastName)),
                );

              },
            ),
          ],
        );
      },
    );
  }
}


