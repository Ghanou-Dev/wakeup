import 'package:g_lab/features/stopwatch/domain/entities/lap_entity.dart';

class LapModel {
  final int index;
  final String time;
  LapModel({
    required this.index,
    required this.time,
  });
  factory LapModel.fromJson(Map<String, dynamic> jsonData) {
    return LapModel(
      index: jsonData['index'],
      time: jsonData['time'],
    );
  }

  factory LapModel.fromEntity(LapEntity lapEntity) {
    return LapModel(
      index: lapEntity.index,
      time: lapEntity.time,
    );
  }

  LapEntity toEntity() {
    return LapEntity(
      index: index,
      time: time,
    );
  }
}
