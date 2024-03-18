
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ma Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/your_image.png', // Chemin de votre image
                  width: 200, // Largeur de l'image
                  height: 200, // Hauteur de l'image
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Action à effectuer lorsque le premier bouton est pressé
                    },
                    child: Text('Bouton 1'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action à effectuer lorsque le deuxième bouton est pressé
                    },
                    child: Text('Bouton 2'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action à effectuer lorsque le troisième bouton est pressé
                    },
                    child: Text('Bouton 3'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
