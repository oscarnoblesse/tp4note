import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';

class pageJoueur extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<pageJoueur> {
  final TextEditingController _numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _counter = 0;
  String _topText = '';
  int _randomNumber = 0;
  int _nombreNiveau = 1;

  @override
  void initState() {
    super.initState();
    // Initialisation de _randomNumber avec un nombre aléatoire entre 0 et 100000
    _randomNumber = Random().nextInt(10^_nombreNiveau);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page avec Popup'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                _nombreNiveau = _nombreNiveau*10;
                Navigator.pop(context); // Fermer la boîte de dialogue
                initState();
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
      if(_randomNumber < int.parse(text)){
        _topText = "Trop grand";
      }
      else if(_randomNumber > int.parse(text)){
        _topText = "Trop petit";
      }
      else if(_randomNumber == int.parse(text)){
        _topText = "Bien jouer tu est trop fort";
        _showPropositionNextLevel(context);
      }

    });
  }



}