import 'dart:developer';

import 'package:g_lab/core/errors/exceptions.dart';
import 'package:g_lab/core/services/app_alarm_service.dart';
import 'package:g_lab/features/alarm/data/models/alarm_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class AlarmLocaleDatasource {
  final Box<AlarmModel> boxAlarms;
  final Box<bool> isFirstLunchBox;
  AlarmLocaleDatasource({
    required this.boxAlarms,
    required this.isFirstLunchBox,
  });

  Future<List<AlarmModel>> saveAlarm({required AlarmModel alarm}) async {
    try {
      await boxAlarms.put(alarm.id, alarm);
      return boxAlarms.values.toList();
    } on Exception catch (e) {
      throw UnsavedException(message: e.toString());
    }
  }

  Future<List<AlarmModel>> getAlarms() async {
    try {
      return boxAlarms.values.toList();
    } on Exception catch (e) {
      throw GetAlarmsException(message: e.toString());
    }
  }

  Future<List<AlarmModel>> deleteAlarm({required AlarmModel alarm}) async {
    AlarmModel alarmDeleted = boxAlarms.values.firstWhere(
      (e) => e.id == alarm.id,
    );
    try {
      await alarmDeleted.delete();
      // stop alarm
      await AppAlarmService.deleteAlarm(id: int.parse(alarm.id));
      return boxAlarms.values.toList();
    } on Exception catch (e) {
      throw DeleteAlarmException(message: e.toString());
    }
  }

  Future<List<AlarmModel>> updateAlarm({
    required AlarmModel oldAlarm,
    required AlarmModel newAlarm,
  }) async {
    try {
      await boxAlarms.put(oldAlarm.id, newAlarm);
      log('${newAlarm.isActive}');
      if (newAlarm.isActive) {
        final now = DateTime.now();
        DateTime alarmDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          newAlarm.time.hour,
          newAlarm.time.minute,
        );
        if (now.isAfter(alarmDateTime)) {
          alarmDateTime = alarmDateTime.add(const Duration(days: 1));
        }
        // start alarm
        await AppAlarmService.createAlarm(
          alarmEntity: newAlarm.toEntity(),
          dateTime: alarmDateTime,
          vibrate: true,
        );
      } else {
        // stop alarm
        await AppAlarmService.deleteAlarm(id: int.parse(newAlarm.id));
      }
      return boxAlarms.values.toList();
    } on Exception catch (e) {
      throw UpdateAlarmException(message: e.toString());
    }
  }

  // get first lunch app
  Future<bool> isFirstLunch() async {
    return isFirstLunchBox.get('isFirstLunch') ?? true;
  }

  Future<void> copmlitedFirstLunch() async {
    await isFirstLunchBox.put('isFirstLunch', false);
  }
}
