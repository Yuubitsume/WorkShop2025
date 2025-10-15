// lib/screens/resultat_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tri_des_sorciers/main.dart';
import 'package:tri_des_sorciers/models/sorcier_type.dart';

class ResultatScreen extends StatelessWidget {
  const ResultatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QCMController>(context, listen: false);
    final SorcierType resultat = controller.resultatFinal!;

    // Convertir la couleur Hex String en objet Color de Flutter
    final Color couleurPrincipale = Color(int.parse(resultat.couleurHex));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Votre Résultat !'),
        backgroundColor: couleurPrincipale,
        automaticallyImplyLeading: false, // Supprime le bouton retour
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'FÉLICITATIONS !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 20),
              
              Text(
                resultat.nom,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: couleurPrincipale,
                ),
              ),
              const SizedBox(height: 30),
              
              // Image du sorcier (à placer dans assets/images/)
              Image.asset(
                'assets/images/${resultat.imagePath}',
                height: 150,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.star, size: 100, color: Colors.amber), // Placeholder
              ),
              const SizedBox(height: 40),

              Text(
                resultat.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: () {
                  controller.recommencer();
                  Navigator.of(context).pop(); // Retour à l'accueil
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: couleurPrincipale,
                  foregroundColor: Colors.white,
                ),
                child: const Text('REFAIRE LE TRI', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}