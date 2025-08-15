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
    const double btnSize = 45; // tamaño uniforme

    return Column(
      children: [
        const Text(
          'Controles:',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 16),

        // Botón rotar
        GestureDetector(
          onTap: gameOver || isPaused ? null : onRotate,
          child: Image.asset(
            'assets/images/buttons/btn_rotar.png',
            width: btnSize,
            height: btnSize,
          ),
        ),
        const SizedBox(height: 8),

        // Botones de movimiento
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: gameOver || isPaused ? null : onMoveLeft,
              child: Image.asset(
                'assets/images/buttons/btn_flecha_izq.png',
                width: btnSize,
                height: btnSize,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: gameOver || isPaused ? null : onMoveRight,
              child: Image.asset(
                'assets/images/buttons/btn_flecha_der.png',
                width: btnSize,
                height: btnSize,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Botón caída rápida
        GestureDetector(
          onTap: gameOver || isPaused ? null : onSoftDrop,
          child: Image.asset(
            'assets/images/buttons/btn_flecha_abj.png',
            width: btnSize,
            height: btnSize,
          ),
        ),
        const SizedBox(height: 8),

        // Botón caída suave
        GestureDetector(
          onTap: gameOver || isPaused ? null : onHardDrop,
          child: Image.asset(
            'assets/images/buttons/btn_caida_rapida.png',
            width: btnSize,
            height: btnSize,
          ),
        ),
      ],
    );
  }
}
