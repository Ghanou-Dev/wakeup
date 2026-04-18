part of 'timer_cubit.dart';

class TimerState {
  final bool isRun;
  final bool ringing;
  final Duration duration;
  final int hour;
  final int minute;
  final int second;
  TimerState({
    required this.isRun,
    required this.ringing,
    required this.duration,
    required this.hour,
    required this.minute,
    required this.second,
  });

  TimerState copyWith({
    bool? isRun,
    bool? ringing,
    Duration? duration,
    int? hour,
    int? minute,
    int? second,
  }) {
    return TimerState(
      isRun: isRun ?? this.isRun,
      ringing: ringing ?? this.ringing,
      duration: duration ?? this.duration,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      second: second ?? this.second,
    );
  }
}
