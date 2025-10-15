// lib/models/sorcier_type.dart

class SorcierType {
  final String nom;
  final String description;
  final String couleurHex; // Pour le design
  final String imagePath; // Pour le résultat

  SorcierType({
    required this.nom,
    required this.description,
    required this.couleurHex,
    required this.imagePath,
  });
}