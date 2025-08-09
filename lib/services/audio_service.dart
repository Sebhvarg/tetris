import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  late AudioPlayer _backgroundPlayer;
  bool _isInitialized = false;
  bool _isMusicEnabled = true;
  bool _isPlaying = false;

  bool get isMusicEnabled => _isMusicEnabled;
  bool get isPlaying => _isPlaying;

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _backgroundPlayer = AudioPlayer();
    _isInitialized = true;
    
    // Configurar el reproductor para loop
    _backgroundPlayer.onPlayerComplete.listen((_) {
      if (_isMusicEnabled && _isPlaying) {
        playBackgroundMusic();
      }
    });
  }

  Future<void> playBackgroundMusic() async {
    if (!_isInitialized) await initialize();
    
    if (_isMusicEnabled && !_isPlaying) {
      try {
        await _backgroundPlayer.play(AssetSource('music/theme.mp3'));
        _isPlaying = true;
        
        // Configurar para que se repita automáticamente
        await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
        await _backgroundPlayer.setVolume(0.6); // Volumen al 60%
      } catch (e) {
        // Error reproduciendo música: $e
      }
    }
  }

  Future<void> pauseBackgroundMusic() async {
    if (_isInitialized && _isPlaying) {
      await _backgroundPlayer.pause();
      _isPlaying = false;
    }
  }

  Future<void> resumeBackgroundMusic() async {
    if (_isInitialized && !_isPlaying && _isMusicEnabled) {
      await _backgroundPlayer.resume();
      _isPlaying = true;
    }
  }

  Future<void> stopBackgroundMusic() async {
    if (_isInitialized) {
      await _backgroundPlayer.stop();
      _isPlaying = false;
    }
  }

  void toggleMusic() {
    _isMusicEnabled = !_isMusicEnabled;
    
    if (_isMusicEnabled) {
      playBackgroundMusic();
    } else {
      pauseBackgroundMusic();
    }
  }

  Future<void> setVolume(double volume) async {
    if (_isInitialized) {
      await _backgroundPlayer.setVolume(volume.clamp(0.0, 1.0));
    }
  }

  Future<void> dispose() async {
    if (_isInitialized) {
      await _backgroundPlayer.dispose();
      _isInitialized = false;
      _isPlaying = false;
    }
  }
}
