import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import '../models/tetromino.dart';
import '../enums/tetromino_type.dart';
import '../utils/game_constants.dart';
import '../widgets/game_board.dart';
import '../widgets/next_piece_widget.dart';
import '../widgets/game_info.dart';
import '../widgets/game_controls.dart';

class TetrisGameScreen extends StatefulWidget {
  const TetrisGameScreen({super.key});

  @override
  State<TetrisGameScreen> createState() => _TetrisGameScreenState();
}

class _TetrisGameScreenState extends State<TetrisGameScreen> {
  List<List<Color?>> board = List.generate(
    GameConstants.boardHeight,
    (index) => List.generate(GameConstants.boardWidth, (index) => null),
  );
  
  Tetromino? currentPiece;
  Tetromino? nextPiece;
  Timer? gameTimer;
  int score = 0;
  int level = 1;
  int linesCleared = 0;
  bool gameOver = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  void startGame() {
    board = List.generate(
      GameConstants.boardHeight,
      (index) => List.generate(GameConstants.boardWidth, (index) => null),
    );
    score = 0;
    level = 1;
    linesCleared = 0;
    gameOver = false;
    isPaused = false;
    
    spawnNewPiece();
    startGameLoop();
  }

  void startGameLoop() {
    gameTimer?.cancel();
    int dropTime = GameConstants.baseDropTime - (level - 1) * GameConstants.speedIncrement;
    if (dropTime < GameConstants.minDropTime) dropTime = GameConstants.minDropTime;
    
    gameTimer = Timer.periodic(Duration(milliseconds: dropTime), (timer) {
      if (!isPaused && !gameOver) {
        dropPiece();
      }
    });
  }

  void spawnNewPiece() {
    if (nextPiece == null) {
      nextPiece = generateRandomPiece();
    }
    
    currentPiece = nextPiece;
    nextPiece = generateRandomPiece();
    
    currentPiece!.x = GameConstants.initialX;
    currentPiece!.y = GameConstants.initialY;
    
    if (isCollision(currentPiece!, 0, 0)) {
      setState(() {
        gameOver = true;
      });
      gameTimer?.cancel();
    }
  }

  Tetromino generateRandomPiece() {
    final types = TetrominoType.values;
    final randomType = types[Random().nextInt(types.length)];
    return Tetromino.fromType(randomType);
  }

  bool isCollision(Tetromino piece, int deltaX, int deltaY, [int? rotation]) {
    int testRotation = rotation ?? piece.currentRotation;
    List<List<int>> shape = piece.rotations[testRotation];
    
    for (int y = 0; y < shape.length; y++) {
      for (int x = 0; x < shape[y].length; x++) {
        if (shape[y][x] == 1) {
          int newX = piece.x + x + deltaX;
          int newY = piece.y + y + deltaY;
          
          // Verificar límites del tablero
          if (newX < 0 || newX >= GameConstants.boardWidth || newY >= GameConstants.boardHeight) {
            return true;
          }
          
          // Verificar colisión con piezas ya colocadas
          if (newY >= 0 && board[newY][newX] != null) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void placePiece() {
    if (currentPiece == null) return;
    
    List<List<int>> shape = currentPiece!.currentShape;
    for (int y = 0; y < shape.length; y++) {
      for (int x = 0; x < shape[y].length; x++) {
        if (shape[y][x] == 1) {
          int boardY = currentPiece!.y + y;
          int boardX = currentPiece!.x + x;
          if (boardY >= 0 && boardY < GameConstants.boardHeight && 
              boardX >= 0 && boardX < GameConstants.boardWidth) {
            board[boardY][boardX] = currentPiece!.color;
          }
        }
      }
    }
    
    clearLines();
    spawnNewPiece();
  }

  void clearLines() {
    int clearedCount = 0;
    
    for (int y = GameConstants.boardHeight - 1; y >= 0; y--) {
      bool isLineFull = true;
      for (int x = 0; x < GameConstants.boardWidth; x++) {
        if (board[y][x] == null) {
          isLineFull = false;
          break;
        }
      }
      
      if (isLineFull) {
        board.removeAt(y);
        board.insert(0, List.generate(GameConstants.boardWidth, (index) => null));
        clearedCount++;
        y++; // Verificar la misma línea de nuevo
      }
    }
    
    if (clearedCount > 0) {
      setState(() {
        linesCleared += clearedCount;
        score += clearedCount * GameConstants.baseLineScore * level;
        level = (linesCleared ~/ GameConstants.linesPerLevel) + 1;
      });
      startGameLoop(); // Reiniciar timer con nueva velocidad
    }
  }

  void dropPiece() {
    if (currentPiece == null) return;
    
    if (!isCollision(currentPiece!, 0, 1)) {
      setState(() {
        currentPiece!.moveDown();
      });
    } else {
      placePiece();
      setState(() {});
    }
  }

  void movePieceLeft() {
    if (currentPiece != null && !isCollision(currentPiece!, -1, 0)) {
      setState(() {
        currentPiece!.moveLeft();
      });
    }
  }

  void movePieceRight() {
    if (currentPiece != null && !isCollision(currentPiece!, 1, 0)) {
      setState(() {
        currentPiece!.moveRight();
      });
    }
  }

  void rotatePiece() {
    if (currentPiece == null) return;
    
    int nextRotation = (currentPiece!.currentRotation + 1) % currentPiece!.rotations.length;
    if (!isCollision(currentPiece!, 0, 0, nextRotation)) {
      setState(() {
        currentPiece!.rotate();
      });
    }
  }

  void hardDrop() {
    if (currentPiece == null) return;
    
    while (!isCollision(currentPiece!, 0, 1)) {
      currentPiece!.moveDown();
      score += GameConstants.hardDropBonus;
    }
    placePiece();
    setState(() {});
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Tetris'),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
            onPressed: togglePause,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: startGame,
          ),
        ],
      ),
      body: gameOver
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Game Over',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Puntuación: $score',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: startGame,
                    child: const Text('Jugar de nuevo'),
                  ),
                ],
              ),
            )
          : Row(
              children: [
                // Tablero de juego
                Expanded(
                  flex: 2,
                  child: GameBoard(
                    board: board,
                    currentPiece: currentPiece,
                  ),
                ),
                // Panel lateral con información y controles
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Información del juego
                        GameInfo(
                          score: score,
                          level: level,
                          linesCleared: linesCleared,
                        ),
                        const SizedBox(height: 20),
                        
                        // Próxima pieza
                        NextPieceWidget(nextPiece: nextPiece),
                        
                        const Spacer(),
                        
                        // Controles
                        GameControls(
                          gameOver: gameOver,
                          isPaused: isPaused,
                          onRotate: rotatePiece,
                          onMoveLeft: movePieceLeft,
                          onMoveRight: movePieceRight,
                          onHardDrop: hardDrop,
                          onSoftDrop: dropPiece,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
