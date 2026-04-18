import 'package:g_lab/features/stopwatch/domain/entities/lap_entity.dart';
import 'package:g_lab/features/stopwatch/domain/services/stopwatch_service.dart';

class StopwatchServiceImpl implements StopwatchService {
  final Stopwatch stopwatch;
  StopwatchServiceImpl({
    required this.stopwatch,
  });

  @override
  void start() {
    stopwatch.start();
  }

  @override
  void pause() {
    stopwatch.stop();
  }

  @override
  void reset() {
    stopwatch.reset();
  }

  @override
  void resume() {
    start();
  }

  @override
  String update() {
    final int minutes = stopwatch.elapsed.inMinutes;
    final int secondes = stopwatch.elapsed.inSeconds % 60;
    final int millisecondes = stopwatch.elapsed.inMilliseconds % 1000;
    return '${minutes.toString().padLeft(2, '0')} : ${secondes.toString().padLeft(2, '0')}.${millisecondes.toString().padLeft(3, '0')}';
  }

  @override
  List<LapEntity> getLap({required List<LapEntity> laps}) {
    String currentLap = update();
    List<LapEntity> currentLaps = List.from(laps)
      ..add(
        LapEntity(index: laps.length + 1, time: currentLap),
      );

    return currentLaps;
  }

  @override
  bool checkOverTime() {
    return stopwatch.elapsed.inMinutes >= 60;
  }
}
