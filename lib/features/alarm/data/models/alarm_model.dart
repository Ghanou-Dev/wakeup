import 'package:flutter/material.dart';
import 'package:g_lab/core/constants/alarm_repited.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:hive_ce/hive_ce.dart';

class AlarmModel extends HiveObject {
  final String hint;
  final TimeOfDay time;
  final AlarmRepited repited;
  final bool isActive;
  final String id;
  AlarmModel({
    required this.hint,
    required this.time,
    required this.repited,
    required this.isActive,
    required this.id,
  });

  // fromJson
  factory AlarmModel.fromJson(Map<String, dynamic> jsonData) {
    return AlarmModel(
      hint: jsonData['hint'],
      time: jsonData['time'],
      repited: jsonData['repited'],
      isActive: jsonData['isActive'],
      id: jsonData['id'],
    );
  }

  // from entity
  factory AlarmModel.fromEntity(AlarmEntity alarmEntity) {
    return AlarmModel(
      hint: alarmEntity.hint,
      time: alarmEntity.time,
      repited: alarmEntity.repited,
      isActive: alarmEntity.isActive,
      id: alarmEntity.id,
    );
  }

  // to entity
  AlarmEntity toEntity() {
    return AlarmEntity(
      hint: hint,
      time: time,
      repited: repited,
      isActive: isActive,
      id: id,
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      'hint': hint,
      'time': time,
      'repited': repited,
      'isActive': isActive,
      'id': id,
    };
  }
}
