import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'pages/pageAccueil.dart'; // Assurez-vous de remplacer 'your_package_name' par le nom réel de votre package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = initializeDatabase();
  runApp(MyApp(database: database));
}

Future<Database> initializeDatabase() async {
  final path = join(await getDatabasesPath(), 'dataBaseUtilisateur3.db');
  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE Score1 (
          id INTEGER PRIMARY KEY,
          nom TEXT,
          prenom TEXT,
          nombreCout Int,
          niveau Int
        )
      ''');
    },
    version: 1,
  );
}

class MyApp extends StatelessWidget {
  final Future<Database> database;
  const MyApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccueilPage(database: database),
    );
  }
}
