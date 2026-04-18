part of 'alarm_cubit.dart';

class AlarmState {
  final List<AlarmEntity> alarms;
  final String? errorMessage;
  final bool isFirstLunch;
  AlarmState({
    required this.alarms,
    this.errorMessage,
    required this.isFirstLunch,
  });

  AlarmState copyWith({
    List<AlarmEntity>? alarms,
    String? errorMessage,
    bool? isFirstLunch,
  }) {
    return AlarmState(
      alarms: alarms ?? this.alarms,
      errorMessage: errorMessage ?? this.errorMessage,
      isFirstLunch: isFirstLunch ?? this.isFirstLunch,
    );
  }
}
