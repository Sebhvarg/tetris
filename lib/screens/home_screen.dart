import 'package:flutter/material.dart';
import 'tetris_game_screen.dart';
import '../services/audio_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioService _audioService = AudioService();

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    await _audioService.initialize();
    await _audioService.playBackgroundMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/inicio.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 70),

              // Botón principal de jugar
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TetrisGameScreen(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset(
                      'assets/images/buttons/btn_jugar.png',
                      fit: BoxFit.contain,
                      height: 70,
                    ),
                  ),
                ),

              const SizedBox(height: 30),

              // Botones secundarios
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón de música
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade600.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _audioService.toggleMusic();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _audioService.isMusicEnabled
                                  ? 'Música activada'
                                  : 'Música desactivada',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: Icon(
                        _audioService.isMusicEnabled
                            ? Icons.volume_up
                            : Icons.volume_off,
                        color: Colors.white,
                        size: 30,
                      ),
                      padding: const EdgeInsets.all(15),
                    ),
                  ),

                  // Botón de puntuaciones
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade600.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Implementar pantalla de puntuaciones
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Puntuaciones próximamente'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.leaderboard,
                        color: Colors.white,
                        size: 30,
                      ),
                      padding: const EdgeInsets.all(15),
                    ),
                  ),

                  // Botón de información
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade600.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        _showInfoDialog(context);
                      },
                      icon: const Icon(
                        Icons.info,
                        color: Colors.white,
                        size: 30,
                      ),
                      padding: const EdgeInsets.all(15),
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 2),

              // Texto de créditos
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Tetris - 2025',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Acerca de Tetris',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Tetris es un videojuego de puzzle creado por Alexey Pajitnov en 1984.\n\n'
            'Objetivo:\n'
            '• Completa líneas horizontales para eliminarlas\n'
            '• Evita que las piezas lleguen hasta arriba\n'
            '• Consigue la mayor puntuación posible\n\n'
            'Controles:\n'
            '• Usa los botones para mover y rotar las piezas\n'
            '• Caída rápida para acelerar las piezas\n'
            '• Pausa el juego cuando necesites',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Entendido',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }
}
