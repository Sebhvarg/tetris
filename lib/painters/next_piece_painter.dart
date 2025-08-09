import 'package:flutter/material.dart';
import '../models/tetromino.dart';

// Painter para dibujar la próxima pieza
class NextPiecePainter extends CustomPainter {
  final Tetromino piece;

  NextPiecePainter(this.piece);

  @override
  void paint(Canvas canvas, Size size) {
    List<List<int>> shape = piece.currentShape;
    double cellSize = size.width / 4;
    
    Paint paint = Paint()..color = piece.color;
    
    for (int y = 0; y < shape.length; y++) {
      for (int x = 0; x < shape[y].length; x++) {
        if (shape[y][x] == 1) {
          canvas.drawRect(
            Rect.fromLTWH(
              x * cellSize + 5,
              y * cellSize + 5,
              cellSize - 2,
              cellSize - 2,
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
