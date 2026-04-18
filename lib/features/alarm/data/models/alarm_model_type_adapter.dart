import 'package:g_lab/features/alarm/data/models/alarm_model.dart';
import 'package:hive_ce/hive_ce.dart';

class AlarmModelTypeAdapter extends TypeAdapter<AlarmModel> {
  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, AlarmModel obj) {
    writer.writeString(obj.hint);
    writer.write(obj.time);
    writer.write(obj.repited);
    writer.writeBool(obj.isActive);
    writer.writeString(obj.id);
  }

  @override
  AlarmModel read(BinaryReader reader) {
    return AlarmModel(
      hint: reader.readString(),
      time: reader.read(),
      repited: reader.read(),
      isActive: reader.readBool(),
      id: reader.readString(),
    );
  }
}
