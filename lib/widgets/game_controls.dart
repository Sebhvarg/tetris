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
            child: const Text('Rotar'),
          ),
        ),
        const SizedBox(height: 8),
        
        // Botones de movimiento
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: gameOver || isPaused ? null : onMoveLeft,
                child: const Text('←'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: gameOver || isPaused ? null : onMoveRight,
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
            child: const Text('Caída rápida'),
          ),
        ),
        const SizedBox(height: 8),
        
        // Botón caída suave
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: gameOver || isPaused ? null : onSoftDrop,
            child: const Text('Bajar'),
          ),
        ),
      ],
    );
  }
}
