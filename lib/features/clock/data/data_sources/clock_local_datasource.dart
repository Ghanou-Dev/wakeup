import 'package:g_lab/features/clock/data/models/location_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

abstract class ClockLocalDatasource {
  Future<Set<LocationModel>> saveLocation({required LocationModel location});
  Future<Set<LocationModel>> deleteLocation({required LocationModel location});
  Future<Set<LocationModel>> getLocations();
}

class ClockLocalDataSourceWithHive implements ClockLocalDatasource {
  final Box<LocationModel> locationsBox;
  ClockLocalDataSourceWithHive({required this.locationsBox});

  @override
  Future<Set<LocationModel>> saveLocation({
    required LocationModel location,
  }) async {
    await locationsBox.add(location);
    return locationsBox.values.toSet();
  }

  @override
  Future<Set<LocationModel>> deleteLocation({
    required LocationModel location,
  }) async {
    LocationModel deletedLocation = locationsBox.values.firstWhere(
      (e) => e.locationName == location.locationName,
    );
    await deletedLocation.delete();
    return locationsBox.values.toSet();
  }

  @override
  Future<Set<LocationModel>> getLocations() async {
    return locationsBox.values.toSet();
  }
}
