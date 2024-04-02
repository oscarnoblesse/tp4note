import 'package:flutter/material.dart';
import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'pageAccueil.dart';
class PageJoueur extends StatefulWidget {
  final Future<Database> database;
  const PageJoueur({Key? key, required this.database}) : super(key: key);
  @override
  _PageJoueurState createState() => _PageJoueurState();
}

class _PageJoueurState extends State<PageJoueur> {
  late Database _database; // Définir le type de la variable _database comme Database

  @override
  void initState() {
    super.initState();
    _initializeDatabase(); // Appeler la méthode _initializeDatabase dans initState
    _generateRandomNumber();
  }

  // Méthode pour initialiser la base de données
  void _initializeDatabase() async {
    // Attendre que la future database soit terminée et assigner sa valeur à _database
    _database = await widget.database;
  }



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
                  _showAddScoreDialog(context);
                },
                child: Text('Ajouter score'),
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
                  _showAddScoreDialog(context); // Lancer la fonction pour afficher la boîte de dialogue
                },
                child: Text('Ajouter score'),
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
                child: Text('Soumettre ce nombre'),
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
                insertScore(name,lastName,_totalTries,_nombreNiveau,_database);

              },
            ),
          ],
        );
      },
    );
  }

  Future<void> insertScore(String nom, String prenom, int score,int niveau ,database) async {
    final Database db = await database; // Récupération de la référence de la base de données

    // Insertion du score dans la table Score
    await db.insert(
      'Score1',
      {
        'nom': nom,
        'prenom': prenom,
        'nombreCout': score,
        'niveau' : niveau
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Remplacement en cas de conflit
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AccueilPage(database: Future.value(database),)),
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