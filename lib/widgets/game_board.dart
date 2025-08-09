import 'package:flutter/material.dart';
import '../models/tetromino.dart';
import '../utils/game_constants.dart';

class GameBoard extends StatelessWidget {
  final List<List<Color?>> board;
  final Tetromino? currentPiece;

  const GameBoard({super.key, required this.board, this.currentPiece});

  Color? getCellColor(int x, int y) {
    // Verificar si hay una pieza actual en esta posición
    if (currentPiece != null) {
      List<List<int>> shape = currentPiece!.currentShape;
      for (int py = 0; py < shape.length; py++) {
        for (int px = 0; px < shape[py].length; px++) {
          if (shape[py][px] == 1) {
            if (currentPiece!.x + px == x && currentPiece!.y + py == y) {
              return currentPiece!.color;
            }
          }
        }
      }
    }

    // Devolver el color de la celda del tablero
    return board[y][x];
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: GameConstants.boardWidth / GameConstants.boardHeight,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: GameConstants.boardWidth,
          ),
          itemCount: GameConstants.boardWidth * GameConstants.boardHeight,
          itemBuilder: (context, index) {
            int x = index % GameConstants.boardWidth;
            int y = index ~/ GameConstants.boardWidth;
            Color? cellColor = getCellColor(x, y);

            return Container(
              decoration: BoxDecoration(
                color: cellColor ?? Colors.grey[900],
                border: Border.all(color: Colors.grey[700]!, width: 0.5),
              ),
            );
          },
        ),
      ),
    );
  }
}
