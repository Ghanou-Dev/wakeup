import 'package:g_lab/features/clock/domain/entities/location_entity.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class LocationModel extends HiveObject {
  String locationName;
  LocationModel({required this.locationName});

  factory LocationModel.fromJson(Map<String, dynamic> jsonData) {
    return LocationModel(locationName: jsonData['location']);
  }

  factory LocationModel.fromEntity({required LocationEntity location}) {
    return LocationModel(locationName: location.locationName);
  }

  LocationEntity toEntity() {
    return LocationEntity(locationName: locationName);
  }

  Map<String, dynamic> toMap() {
    return {
      'location': locationName,
    };
  }
}
