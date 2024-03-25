import 'package:flutter/material.dart';

class NumberGuessingGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Règles du jeu du Nombre Mystère'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bienvenue au jeu du nombre mystère !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Règles du jeu :',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '1. L\'ordinateur choisit un nombre mystère entre 1 et 100.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '2. Le joueur doit deviner ce nombre mystère en proposant des nombres.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '3. À chaque proposition, l\'ordinateur indique si le nombre mystère est plus grand, plus petit ou égal à la proposition du joueur.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '4. Le jeu continue jusqu\'à ce que le joueur trouve le nombre mystère.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '5. Le joueur obtient un score basé sur le nombre de tentatives nécessaires pour trouver le nombre mystère.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Bonne chance !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
