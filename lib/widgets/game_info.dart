import 'package:flutter/material.dart';

class GameInfo extends StatelessWidget {
  final int score;
  final int level;
  final int linesCleared;

  const GameInfo({
    super.key,
    required this.score,
    required this.level,
    required this.linesCleared,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Puntuación: $score',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Nivel: $level',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          'Líneas: $linesCleared',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
