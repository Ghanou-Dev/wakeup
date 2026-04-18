part of 'clock_cubit.dart';

class ClockState {
  Set<tz.Location> savedLocations;
  List<tz.Location> allLocations;
  tz.Location currentLocation;
  ClockState({
    required this.savedLocations,
    required this.allLocations,
    required this.currentLocation,
  });

  ClockState copyWith({
    Set<tz.Location>? savedLocations,
    List<tz.Location>? allLocations,
    tz.Location? currentLocation,
  }) {
    return ClockState(
      savedLocations: savedLocations ?? this.savedLocations,
      allLocations: allLocations ?? this.allLocations,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
