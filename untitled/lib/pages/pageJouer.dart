import 'package:flutter/material.dart';
import 'dart:math';

class pageJoueur extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<pageJoueur> {
  final TextEditingController _numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _counter = 0;
  int _totalTries = 0; // Compteur total d'essais
  int _triesLeft = 30; // Essais initiaux
  String _topText = '';
  int _randomNumber = 0;
  int _minNumber = 0;
  int _maxNumber = 6; // Intervalle initial
  int _nombreNiveau = 1;
  int _initialTries = 30; // Nombre d'essais initial
  int _notreNombre = 0;

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
  }

  void _generateRandomNumber() {
    _randomNumber = Random().nextInt(_maxNumber - _minNumber) + _minNumber;
    print(_randomNumber);
  }

  @override
  Widget build(BuildContext context) {
    if (_triesLeft <= 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Game Over'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Retour à la fenêtre d'accueil
                },
                child: Text('Retour'),
              ),
            ],
          ),
        ),
      );
    } else if (_nombreNiveau == 9 && _randomNumber == _notreNombre) {
      // Condition pour gagner uniquement lorsque le nombre est trouvé au niveau 9
      return Scaffold(
        appBar: AppBar(
          title: Text('You Won'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You Won!',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Nombre total d\'essais: $_totalTries', // Affichage du nombre total d'essais
                style: TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Retour à la fenêtre d'accueil
                },
                child: Text('Retour'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Page avec Popup - Niveau $_nombreNiveau'), // Affichage du niveau actuel dans le titre de l'appBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Interval: $_minNumber - $_maxNumber',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Essais restants: $_triesLeft', // Affichage du nombre d'essais restants
                style: TextStyle(fontSize: 18),
              ),
              Text(
                _topText,
                style: TextStyle(fontSize: 18),
              ),
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Entrez un nombre',
                ),
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_numberController.text != "") {
                    _incrementCounter(_numberController.text);
                  }
                },
                child: Text('Ajouter au compteur'),
              ),
              SizedBox(height: 20),
              Text(
                'Compteur : $_counter',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPropositionNextLevel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Passer au niveau suivant ?'),
          content: Text('Êtes-vous sûr de vouloir passer au niveau suivant ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fermer la boîte de dialogue
              },
              child: Text('Non'),
            ),
            ElevatedButton(
              onPressed: () {
                _nombreNiveau++;
                _minNumber = 0;
                _maxNumber = 6 * _nombreNiveau; // Augmenter l'intervalle de 6 par 6
                _generateRandomNumber();
                // Réinitialiser le nombre d'essais avec la logique appropriée
                if (_triesLeft > 10) {
                  _initialTries -= 5;
                } else {
                  _initialTries -= 2;
                }
                _triesLeft = _initialTries;
                Navigator.pop(context); // Fermer la boîte de dialogue
                setState(() {
                  _topText = '';
                });
              },
              child: Text('Oui'),
            ),
          ],
        );
      },
    );
  }

  void _incrementCounter(String text) {
    setState(() {
      _counter += 1;
      _numberController.clear();
      int guessedNumber = int.parse(text);
      _triesLeft--; // Décrémenter le nombre d'essais à chaque tentative
      _totalTries++; // Incrémenter le nombre total d'essais
      _notreNombre = guessedNumber;
      if (_randomNumber < guessedNumber) {
        _topText = "Trop grand";
        _maxNumber = guessedNumber;
      } else if (_randomNumber > guessedNumber) {
        _topText = "Trop petit";
        _maxNumber = _maxNumber; // Garder le maximum inchangé
        _minNumber = guessedNumber; // Mettre à jour seulement le minimum
      } else if (_randomNumber == guessedNumber) {
        _topText = "Bien jouer tu es trop fort";
        if (_nombreNiveau != 9) {
          _showPropositionNextLevel(context);
        }
      }
    });
  }


}