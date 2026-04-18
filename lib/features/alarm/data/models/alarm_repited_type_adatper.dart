import 'package:g_lab/core/constants/alarm_repited.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class AlarmRepitedTypeAdatper extends TypeAdapter<AlarmRepited> {
  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, AlarmRepited obj) {
    writer.writeInt(obj.index);
  }

  @override
  AlarmRepited read(BinaryReader reader) {
    return AlarmRepited.values[reader.readInt()];
  }
}
