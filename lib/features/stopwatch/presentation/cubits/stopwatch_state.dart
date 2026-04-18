part of 'stopwatch_cubit.dart';

class StopwatchState {
  final String time;
  final bool isRunning;
  final bool isPaused;
  final List<LapEntity> laps;
  StopwatchState({
    required this.time,
    required this.isRunning,
    required this.isPaused,
    required this.laps,
  });

  StopwatchState copyWith({
    String? time,
    bool? isRunning,
    bool? isPaused,
    List<LapEntity>? laps,
    String? currentLap,
  }) {
    return StopwatchState(
      time: time ?? this.time,
      isRunning: isRunning ?? this.isRunning,
      isPaused: isPaused ?? this.isPaused,
      laps: laps ?? this.laps,
    );
  }
}
