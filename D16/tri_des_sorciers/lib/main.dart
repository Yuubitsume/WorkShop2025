// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tri_des_sorciers/data/qcm_data.dart' as data;
import 'package:tri_des_sorciers/models/question.dart';
import 'package:tri_des_sorciers/models/sorcier_type.dart';
import 'package:tri_des_sorciers/screens/accueil_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QCMController(),
      child: const SorcierApp(),
    ),
  );
}

class SorcierApp extends StatelessWidget {
  const SorcierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Le Tri des Sorciers',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: const AccueilScreen(),
    );
  }
}

// --- Le Contrôleur d'État (pour le QCM) ---

class QCMController with ChangeNotifier {
  // Initialisation du champ _questions avec la variable globale 'questions'
  final List<Question> _questions = data.qcmQuestions; 
  final Map<String, int> _scores = {
    // alchimiste, mystique, chronomancien, sauvage sont des variables globales importées de qcm_data.dart
    data.alchimiste.nom: 0,
    data.mystique.nom: 0,
    data.chronomancien.nom: 0,
    data.sauvage.nom: 0,
  };
  int _indexQuestion = 0;
  SorcierType? _resultatFinal;

  int get indexQuestion => _indexQuestion;
  // Le getter simple ne cause pas de problème d'initialisation 'this'
  List<Question> get questions => _questions; 
  SorcierType? get resultatFinal => _resultatFinal;
  bool get estTermine => _indexQuestion >= _questions.length;

  void repondre(Reponse reponse) {
    // 1. Appliquer les points
    reponse.points.forEach((typeNom, points) {
      // Correction du type : on s'assure que le résultat de l'addition est un 'int'
     _scores[typeNom] = ((_scores[typeNom] ?? 0) + points).toInt(); 
    });

    // 2. Passer à la question suivante
    _indexQuestion++;

    // 3. Vérifier la fin du QCM
    if (estTermine) {
      _resultatFinal = data.determinerSorcier(_scores);
    }

    notifyListeners(); // Rafraîchit l'interface utilisateur
  }

  void recommencer() {
    _indexQuestion = 0;
    _resultatFinal = null;
    _scores.updateAll((key, value) => 0); // Remet tous les scores à zéro
    notifyListeners();
 }
}