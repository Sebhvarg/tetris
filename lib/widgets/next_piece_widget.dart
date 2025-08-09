import 'package:flutter/material.dart';
import '../models/tetromino.dart';
import '../painters/next_piece_painter.dart';

class NextPieceWidget extends StatelessWidget {
  final Tetromino? nextPiece;

  const NextPieceWidget({
    super.key,
    required this.nextPiece,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Próxima pieza:',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.grey[900],
          ),
          child: nextPiece != null
              ? CustomPaint(
                  painter: NextPiecePainter(nextPiece!),
                )
              : null,
        ),
      ],
    );
  }
}
