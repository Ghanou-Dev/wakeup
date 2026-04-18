import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:vibration/vibration.dart';

class AppAudioService {
  final AudioPlayer player = AudioPlayer();
  // Singlton
  AppAudioService._();
  static final AppAudioService _instance = AppAudioService._();
  factory AppAudioService() {
    return _instance;
  }

  Future<void> play() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(
        pattern: [0, 500, 500, 500],
        repeat: 0,
      );
    }
    await player.setAudioSource(
      AudioSource.asset(
        'assets/sounds/alarm.mp3',
        tag: const MediaItem(
          id: '001Gon',
          title: 'Time\'s up',
          displayDescription: 'This is the discription',
        ),
      ),
    );
    await player.play();
  }

  Future<void> stop() async {
    await Vibration.cancel();
    await player.stop();
  }
}
