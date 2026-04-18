import 'dart:async';
import 'dart:io';
import 'package:alarm/alarm.dart';
import 'package:alarm/utils/alarm_set.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';

class AppAlarmService {
  // listen to alarm starting //////////////////////////////////////////////////
  static StreamSubscription<AlarmSet> listenToAlarmStart({
    required void Function(AlarmSettings alarmSettings) onAlarmStart,
  }) {
    return Alarm.ringing.listen((AlarmSet alarmSet) {
      for (AlarmSettings alarm in alarmSet.alarms) {
        // do some thing
        onAlarmStart(alarm);
      }
    });
  }

  // create alarm //////////////////////////////////////////////////////////////
  static Future<void> createAlarm({
    required AlarmEntity alarmEntity,
    required DateTime dateTime,
    required bool vibrate,
  }) async {
    AlarmSettings alarmSettings = AlarmSettings(
      id: int.parse(alarmEntity.id) % 2147483647,
      dateTime: dateTime,
      assetAudioPath: 'assets/sounds/alarm.mp3',
      loopAudio: true,
      vibrate: vibrate,
      warningNotificationOnKill: Platform.isIOS,
      androidFullScreenIntent: true,
      volumeSettings: VolumeSettings.fade(
        volume: 0.8,
        fadeDuration: const Duration(seconds: 5),
        volumeEnforced: true,
      ),
      notificationSettings: NotificationSettings(
        title: alarmEntity.hint,
        body:
            "Alarm ${alarmEntity.time.hour}:${alarmEntity.time.minute} ${alarmEntity.time.period.name.toUpperCase()}",
        stopButton: 'Stop',
        icon: 'notification_icon',
        iconColor: AppColors.deepGrey,
      ),
    );
    // set alarm
    await Alarm.set(alarmSettings: alarmSettings);
  }

  // delete alarm //////////////////////////////////////////////////////////////
  static Future<void> deleteAlarm({required int id}) async {
    await Alarm.stop(id % 2147483647);
  }
}
