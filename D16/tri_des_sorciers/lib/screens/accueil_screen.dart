// lib/screens/accueil_screen.dart
import 'package:flutter/material.dart';
import 'package:tri_des_sorciers/screens/qcm_screen.dart';

class AccueilScreen extends StatelessWidget {
  const AccueilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Le Tri des Sorciers'),
        backgroundColor: Colors.indigo.shade800,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Découvrez votre véritable nature magique !',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              const Text(
                'Répondez aux 20 questions pour être trié dans l\'une des 4 Maisons de l\'Ordre Cosmique : Alchimiste, Mystique, Chronomancien ou Sauvage.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 60),
              ElevatedButton.icon(
                icon: const Icon(Icons.auto_fix_high),
                label: const Text('COMMENCER LE TRI', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const QCMScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}