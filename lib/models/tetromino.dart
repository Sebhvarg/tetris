import 'package:flutter/material.dart';
import '../enums/tetromino_type.dart';
import '../utils/game_constants.dart';

// Clase que representa una pieza de Tetris
class Tetromino {
  final TetrominoType type;
  final Color color;
  final List<List<List<int>>> rotations;
  int currentRotation = 0;
  int x = GameConstants.initialX; // Posición inicial en el tablero
  int y = GameConstants.initialY;

  Tetromino({
    required this.type,
    required this.color,
    required this.rotations,
    required Border border,
  });

  List<List<int>> get currentShape => rotations[currentRotation];

  void rotate() {
    currentRotation = (currentRotation + 1) % rotations.length;
  }

  void moveLeft() => x--;
  void moveRight() => x++;
  void moveDown() => y++;

  // Factory para crear las diferentes piezas
  factory Tetromino.fromType(TetrominoType type) {
    switch (type) {
      case TetrominoType.I:
        return Tetromino(
          type: type,
          color: Colors.cyan,
          border: Border.all(color: Colors.black, width: 2),
          rotations: [
            [
              [1, 1, 1, 1],
            ],
            [
              [1],
              [1],
              [1],
              [1],
            ],
          ],
        );
      case TetrominoType.O:
        return Tetromino(
          type: type,
          color: Colors.yellow,
          border: Border.all(color: Colors.black, width: 2),
          rotations: [
            [
              [1, 1],
              [1, 1],
            ],
          ],
        );
      case TetrominoType.T:
        return Tetromino(
          type: type,
          color: Colors.purple,
          border: Border.all(color: Colors.black, width: 2),
          rotations: [
            [
              [0, 1, 0],
              [1, 1, 1],
            ],
            [
              [1, 0],
              [1, 1],
              [1, 0],
            ],
            [
              [1, 1, 1],
              [0, 1, 0],
            ],
            [
              [0, 1],
              [1, 1],
              [0, 1],
            ],
          ],
        );
      case TetrominoType.S:
        return Tetromino(
          type: type,
          color: Colors.green,
          border: Border.all(color: Colors.black, width: 2),
          rotations: [
            [
              [0, 1, 1],
              [1, 1, 0],
            ],
            [
              [1, 0],
              [1, 1],
              [0, 1],
            ],
          ],
        );
      case TetrominoType.Z:
        return Tetromino(
          type: type,
          color: Colors.red,
          border: Border.all(color: Colors.black, width: 2),
          rotations: [
            [
              [1, 1, 0],
              [0, 1, 1],
            ],
            [
              [0, 1],
              [1, 1],
              [1, 0],
            ],
          ],
        );
      case TetrominoType.J:
        return Tetromino(
          type: type,
          color: Colors.blue,
          border: Border.all(color: Colors.black, width: 2),
          rotations: [
            [
              [1, 0, 0],
              [1, 1, 1],
            ],
            [
              [1, 1],
              [1, 0],
              [1, 0],
            ],
            [
              [1, 1, 1],
              [0, 0, 1],
            ],
            [
              [0, 1],
              [0, 1],
              [1, 1],
            ],
          ],
        );
      case TetrominoType.L:
        return Tetromino(
          type: type,
          color: Colors.orange,
          border: Border.all(color: Colors.black, width: 2),
          rotations: [
            [
              [0, 0, 1],
              [1, 1, 1],
            ],
            [
              [1, 0],
              [1, 0],
              [1, 1],
            ],
            [
              [1, 1, 1],
              [1, 0, 0],
            ],
            [
              [1, 1],
              [0, 1],
              [0, 1],
            ],
          ],
        );
    }
  }
}
