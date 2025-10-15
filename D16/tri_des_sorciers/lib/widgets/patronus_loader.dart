// lib/widgets/patronus_loader.dart - Patronus Serpent Magique (Version 2D Optimisée)

import 'package:flutter/material.dart';
import 'dart:math' show sin, pi, pow; 

// --- WIDGET PRINCIPAL : Gère l'animation et l'interface ---

class PatronusLoader extends StatefulWidget {
  const PatronusLoader({super.key});

  @override
  State<PatronusLoader> createState() => _PatronusLoaderState();
}

class _PatronusLoaderState extends State<PatronusLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Couleurs du Patronus
  final Color spectralLight = const Color(0xFFC7F7FF); 
  final Color spectralShadow = const Color(0xFF0077B6); 
  
  final double lengthFactor = 15.0; 
  final int totalLength = 300; 

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800), 
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0d1117), 
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: totalLength.toDouble(),
              height: 200, 
              child: CustomPaint(
                painter: SnakePatronusPainter(
                  animation: _controller,
                  waveAmplitude: 35.0, 
                  // AUGMENTATION DU NOMBRE D'ONDES SUR LE SERPENT
                  waveFrequency: 2.0, // Nombre de cycles complets sur la longueur visible
                  spectralLight: spectralLight,
                  spectralShadow: spectralShadow,
                  lengthFactor: lengthFactor,
                ),
              ),
            ),
            
            const SizedBox(height: 50),
            
            Text(
              "Expecto Patronum! Le Serpent Gardien...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: spectralLight.withOpacity(0.9),
                fontSize: 20,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(color: spectralShadow.withOpacity(0.8), blurRadius: 15)
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// --- CUSTOM PAINTER : Le moteur de rendu graphique du Patronus ---
// ----------------------------------------------------------------------

class SnakePatronusPainter extends CustomPainter {
  final Animation<double> animation;
  final double waveAmplitude;
  final double waveFrequency; // Nouvelle propriété pour le réalisme de l'ondulation
  final Color spectralLight;
  final Color spectralShadow;
  final double lengthFactor;

  SnakePatronusPainter({
    required this.animation,
    required this.waveAmplitude,
    required this.waveFrequency,
    required this.spectralLight,
    required this.spectralShadow,
    required this.lengthFactor,
  }) : super(repaint: animation); 

  @override
  void paint(Canvas canvas, Size size) {
    const int controlPointCount = 20; 
    final double headThickness = 12.0; 

    final path = Path();
    
    // --- Définition des points du chemin (Courbe de Bézier) ---
    
    // Point de départ (la tête)
    double x = 0;
    // Ondulation au point de départ
    double y = size.height / 2 + waveAmplitude * sin(2 * pi * animation.value);
    path.moveTo(x, y);

    // Construction du corps du serpent
    for (int i = 1; i < controlPointCount; i++) {
      final double t_index = i / controlPointCount; // 0 à 1 sur la longueur
      
      // La fréquence rend l'onde plus serrée (ressemble plus à un serpent)
      // On multiplie par waveFrequency
      final double phaseShift = i * 0.15;
      final double waveY = waveAmplitude * sin(2 * pi * (animation.value + phaseShift) * waveFrequency);
      
      final double nextX = i * lengthFactor;
      final double nextY = size.height / 2 + waveY;
      
      // Courbe de Bézier cubique pour une transition très lisse
      path.cubicTo(
        x + lengthFactor / 2, y, 
        nextX - lengthFactor / 2, nextY, 
        nextX, nextY, 
      );
      
      x = nextX;
      y = nextY;
    }
    
    // --- Styles de Peinture (Application de la Lueur et du Dégradé de Largeur) ---

    // 1. Le Gérage/Lueur Externe (Shadow/Glow)
    final Paint glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0); 

    // 2. Le Corps Lumineux Principal
    final Paint bodyPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pathMetrics = path.computeMetrics();
    
    for (final metric in pathMetrics) {
      final int segmentCount = (metric.length / 5).ceil();
      
      for (int i = 0; i < segmentCount; i++) {
        final double start = i * 5.0;
        final double end = start + 5.0;
        final double t = i / segmentCount; // Proportion (0=Tête, 1=Queue)

        if (start >= metric.length) continue; 
        
        final subPath = metric.extractPath(start, end);

        // --- AMÉLIORATION DE L'ÉPAISSEUR DE LA TÊTE ---
        // La tête est beaucoup plus large pour l'effet "tête de serpent" (1.0 - t)^4
        final double thicknessFactor = pow(1.0 - t, 4.0).toDouble();
        final double thickness = headThickness * (0.8 + 1.2 * thicknessFactor); // Min 0.8, Max 2.0 * headThickness
        
        final double opacity = 1.0 - t * 0.5; 
        
        // Dessin du Glow
        glowPaint.strokeWidth = thickness * 3.5;
        glowPaint.color = spectralShadow.withOpacity(opacity * 0.5);
        canvas.drawPath(subPath, glowPaint);

        // Dessin du Corps Principal
        bodyPaint.strokeWidth = thickness;
        bodyPaint.color = spectralLight.withOpacity(opacity);
        canvas.drawPath(subPath, bodyPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}