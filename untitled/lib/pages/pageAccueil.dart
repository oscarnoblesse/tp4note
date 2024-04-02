import 'package:flutter/material.dart';
import 'pageJouer.dart';
import 'pageRegle.dart';


class AccueilPage extends StatelessWidget {
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
                    _showConfirmationDialog(context);
                  },
                  child: Text('jouer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action à effectuer lorsque le deuxième bouton est pressé
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

  void _showConfirmationDialog(BuildContext context) {
    // Contrôleur pour récupérer la valeur saisie dans le TextField
    TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Entrez votre nom et prénom :'),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Nom et prénom',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fermer la boîte de dialogue
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ne naviguer vers MyHomePage que lorsque l'utilisateur appuie sur "Oui"
                Navigator.pop(context); // Fermer la boîte de dialogue
                _navigateToMyHomePage(context); // Naviguer vers MyHomePage
              },
              child: Text('Oui'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToMyHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pageJoueur()),
    );
  }
}


