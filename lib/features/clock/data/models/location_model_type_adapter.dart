import 'package:g_lab/features/clock/data/models/location_model.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class LocationModelTypeAdapter extends TypeAdapter<LocationModel> {
  @override
  LocationModel read(BinaryReader reader) {
    return LocationModel(
      locationName: reader.readString(),
    );
  }

  @override
  int get typeId => 10;

  @override
  void write(BinaryWriter writer, LocationModel obj) {
    writer.writeString(obj.locationName);
  }
}
