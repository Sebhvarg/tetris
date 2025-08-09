import 'package:flutter/material.dart';

class GameControls extends StatelessWidget {
  final bool gameOver;
  final bool isPaused;
  final VoidCallback onRotate;
  final VoidCallback onMoveLeft;
  final VoidCallback onMoveRight;
  final VoidCallback onHardDrop;
  final VoidCallback onSoftDrop;

  const GameControls({
    super.key,
    required this.gameOver,
    required this.isPaused,
    required this.onRotate,
    required this.onMoveLeft,
    required this.onMoveRight,
    required this.onHardDrop,
    required this.onSoftDrop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Controles:',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 16),

        // Botón rotar
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: gameOver || isPaused ? null : onRotate,
            child: const Text('Rotar', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 8),

        // Botones de movimiento
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: gameOver || isPaused ? null : onMoveLeft,
                style: ElevatedButton.styleFrom(
                  backgroundColor: gameOver || isPaused
                      ? const Color.fromARGB(255, 221, 79, 79)
                      : const Color.fromARGB(255, 0, 0, 0),
                ),
                child: const Text('←', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: gameOver || isPaused ? null : onMoveRight,
                style: ElevatedButton.styleFrom(
                  backgroundColor: gameOver || isPaused
                      ? const Color.fromARGB(255, 221, 79, 79)
                      : const Color.fromARGB(255, 0, 0, 0),
                ),
                child: const Text('→'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Botón caída rápida
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: gameOver || isPaused ? null : onHardDrop,
            style: ElevatedButton.styleFrom(
              backgroundColor: gameOver || isPaused
                  ? const Color.fromARGB(255, 221, 79, 79)
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
            child: const Text(
              'Caída rápida',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Botón caída suave
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: gameOver || isPaused ? null : onSoftDrop,
            style: ElevatedButton.styleFrom(
              backgroundColor: gameOver || isPaused
                  ? const Color.fromARGB(255, 221, 79, 79)
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
            child: const Text('Bajar', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
