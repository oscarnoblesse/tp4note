import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class BestScoresPage extends StatefulWidget {
  final Future<Database> database;

  const BestScoresPage({Key? key, required this.database}) : super(key: key);

  @override
  _BestScoresPageState createState() => _BestScoresPageState();
}

class _BestScoresPageState extends State<BestScoresPage> {
  late Future<List<Map<String, dynamic>>> _bestScores;

  @override
  void initState() {
    super.initState();
    _bestScores = _getBestScores();
  }

  Future<List<Map<String, dynamic>>> _getBestScores() async {
    final Database db = await widget.database;
    final List<Map<String, dynamic>> scores = await db.rawQuery(
      'SELECT nom, prenom, niveau, nombreCout FROM Score1 ORDER BY nombreCout,niveau ASC LIMIT 10',
    );
    return scores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meilleurs Scores'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bestScores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Une erreur est survenue'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun score trouvé'));
          } else {
            final List<Map<String, dynamic>> scores = snapshot.data!;
            return ListView.builder(
              itemCount: scores.length,
              itemBuilder: (context, index) {
                final score = scores[index];
                return ListTile(
                  title: Text('${score['prenom']} ${score['nom']}'),
                  subtitle: Text('Niveau: ${score['niveau']}, Coups: ${score['nombreCout']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
