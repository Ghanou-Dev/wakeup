import 'package:g_lab/features/clock/data/data_sources/clock_local_datasource.dart';
import 'package:g_lab/features/clock/data/models/location_model.dart';
import 'package:g_lab/features/clock/domain/entities/location_entity.dart';
import 'package:g_lab/features/clock/domain/repositories/clock_repo.dart';

class ClockRepoImpl implements ClockRepo {
  final ClockLocalDatasource datasource;
  ClockRepoImpl({required this.datasource});

  @override
  Future<Set<LocationEntity>> addLocation({
    required LocationEntity location,
  }) async {
    LocationModel locationModel = LocationModel.fromEntity(location: location);
    Set<LocationModel> locations = await datasource.saveLocation(
      location: locationModel,
    );
    return locations.map((e) => e.toEntity()).toSet();
  }

  @override
  Future<Set<LocationEntity>> deleteLocation({
    required LocationEntity location,
  }) async {
    Set<LocationModel> locations = await datasource.deleteLocation(
      location: LocationModel.fromEntity(location: location),
    );
    return locations.map((e) => e.toEntity()).toSet();
  }

  @override
  Future<Set<LocationEntity>> getSavedLocation() async {
    Set<LocationModel> locations = await datasource.getLocations();
    return locations.map((e) => e.toEntity()).toSet();
  }
}
