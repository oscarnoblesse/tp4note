import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccueilPage(),
    );
  }
}

Future<Database> openDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'example_database.db'),
    onCreate: (db, version) {
      // Création de la première table
      db.execute(
        "CREATE TABLE table1(id INTEGER PRIMARY KEY, name TEXT, value INTEGER)",
      );
      // Création de la deuxième table
      db.execute(
        "CREATE TABLE table2(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
      );
    },
    version: 1,
  );
}


