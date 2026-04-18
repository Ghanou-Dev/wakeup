import 'package:g_lab/features/stopwatch/domain/entities/lap_entity.dart';

abstract class StopwatchService {
  void start();
  void pause();
  void resume();
  void reset();
  String update();
  List<LapEntity> getLap({required List<LapEntity> laps});
  bool checkOverTime();
}
