// lib/models/question.dart
import 'sorcier_type.dart';

// Représente une réponse possible avec la pondération des points
class Reponse {
  final String texte;
  // Map<Nom du Sorcier, Points gagnés>
  final Map<String, int> points; 

  Reponse({required this.texte, required this.points});
}

// Représente une question
class Question {
  final String texte;
  final List<Reponse> reponses;

  Question({required this.texte, required this.reponses});
}