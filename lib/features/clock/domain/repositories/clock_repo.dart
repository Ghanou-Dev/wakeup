import 'package:g_lab/features/clock/domain/entities/location_entity.dart';

abstract class ClockRepo {
  Future<Set<LocationEntity>> addLocation({required LocationEntity location});
  Future<Set<LocationEntity>> deleteLocation({
    required LocationEntity location,
  });
  Future<Set<LocationEntity>> getSavedLocation();
}
