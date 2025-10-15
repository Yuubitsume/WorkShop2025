// lib/screens/qcm_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tri_des_sorciers/main.dart';
import 'package:tri_des_sorciers/models/question.dart';
import 'package:tri_des_sorciers/screens/resultat_screen.dart';

class QCMScreen extends StatelessWidget {
  const QCMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Écoute les changements dans QCMController
    final controller = Provider.of<QCMController>(context);

    if (controller.estTermine) {
      // Si le QCM est terminé, naviguer vers l'écran de résultat
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const ResultatScreen()),
        );
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = controller.questions[controller.indexQuestion];
    final totalQuestions = controller.questions.length;
    final progress = (controller.indexQuestion + 1) / totalQuestions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${controller.indexQuestion + 1} / $totalQuestions'),
        backgroundColor: Colors.indigo.shade800,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Barre de progression
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              color: Colors.indigo,
              minHeight: 10,
            ),
            const SizedBox(height: 30),
            
            // Texte de la question
            Text(
              currentQuestion.texte,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),

            // Liste des réponses (utilise un Expanded pour le défilement si nécessaire)
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion.reponses.length,
                itemBuilder: (ctx, index) {
                  final reponse = currentQuestion.reponses[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        foregroundColor: Colors.black87,
                        backgroundColor: Colors.indigo.shade50,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        controller.repondre(reponse);
                      },
                      child: Text(
                        reponse.texte,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}