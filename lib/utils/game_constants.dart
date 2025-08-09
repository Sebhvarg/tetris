class GameConstants {
  // Dimensiones del tablero
  static const int boardWidth = 10;
  static const int boardHeight = 20;
  
  // Velocidad del juego
  static const int baseDropTime = 1000; // milliseconds
  static const int speedIncrement = 100; // milliseconds
  static const int minDropTime = 100; // milliseconds
  
  // Puntuación
  static const int baseLineScore = 100;
  static const int hardDropBonus = 2;
  static const int linesPerLevel = 10;
  
  // Posición inicial de las piezas
  static const int initialX = 3;
  static const int initialY = 0;
}
