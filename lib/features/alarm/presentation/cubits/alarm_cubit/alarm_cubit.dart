import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/domain/usecases/completed_first_lunch_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/delete_alarm_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/get_alarms_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/is_first_lunch_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/save_alarm_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/update_alarm_usecase.dart';

part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  final GetAlarmsUsecase getAlarmsUsecase;
  final SaveAlarmUsecase saveAlarmUsecase;
  final DeleteAlarmUsecase deleteAlarmUsecase;
  final UpdateAlarmUsecase updateAlarmUsecase;
  final IsFirstLunchUsecase isFirstLunchUsecase;
  final CompletedFirstLunchUsecase completedFirstLunchUsecase;
  AlarmCubit({
    required this.getAlarmsUsecase,
    required this.saveAlarmUsecase,
    required this.deleteAlarmUsecase,
    required this.updateAlarmUsecase,
    required this.isFirstLunchUsecase,
    required this.completedFirstLunchUsecase,
  }) : super(AlarmState(alarms: [], isFirstLunch: false)) {
    getAlarms();
    checkIsFirstLunch();
  }

  List<AlarmEntity> alarmsList = [];

  // check is first lunch //////////////////////////////////////////////////////
  Future<void> checkIsFirstLunch() async {
    final result = await isFirstLunchUsecase.call();
    emit(state.copyWith(isFirstLunch: result));
  }

  Future<void> completedFirstLunch() async {
    await completedFirstLunchUsecase.call();
  }

  //////////////////////////////////////////////////////////////////////////////
  Stream<TimeOfDay> listenToAlarmDiffrenceTime({
    required AlarmEntity alarm,
  }) async* {
    // get the deffrence betwin alarmTime and current time
    final now = DateTime.now();
    DateTime alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      alarm.time.hour,
      alarm.time.minute,
    );
    if (now.isAfter(alarmTime)) {
      alarmTime = alarmTime.add(const Duration(days: 1));
    }
    int hourRemains = alarmTime.difference(now).inHours;
    int minuteRemains = alarmTime.difference(now).inMinutes % 60;
    TimeOfDay newTime = TimeOfDay(hour: hourRemains, minute: minuteRemains);

    yield newTime;
    // بعدها ابدأ التحديث
    await for (final _ in Stream.periodic(const Duration(minutes: 1))) {
      // get the deffrence betwin alarmTime and current time
      final now = DateTime.now();
      DateTime alarmTime = DateTime(
        now.year,
        now.month,
        now.day,
        alarm.time.hour,
        alarm.time.minute,
      );
      if (now.isAfter(alarmTime)) {
        alarmTime = alarmTime.add(const Duration(days: 1));
      }
      int hourRemains = alarmTime.difference(now).inHours;
      int minuteRemains = alarmTime.difference(now).inMinutes % 60;
      TimeOfDay newTime = TimeOfDay(hour: hourRemains, minute: minuteRemains);
      yield newTime;
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  Future<void> getAlarms() async {
    Either<Failures, List<AlarmEntity>> data = await getAlarmsUsecase();
    data.fold(
      (l) {
        emit(state.copyWith(errorMessage: l.message));
      },
      (r) {
        alarmsList = r;
        emit(
          state.copyWith(
            alarms: r,
            errorMessage: null,
          ),
        );
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  Future<void> saveAlarm({required AlarmEntity alarm}) async {
    Either<Failures, List<AlarmEntity>> data = await saveAlarmUsecase(
      alarm: alarm,
    );
    data.fold(
      (l) {
        emit(state.copyWith(errorMessage: l.message));
      },
      (r) {
        emit(
          state.copyWith(
            alarms: r,
            errorMessage: null,
          ),
        );
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  Future<void> deleteAlarm({required AlarmEntity alarm}) async {
    Either<Failures, List<AlarmEntity>> data = await deleteAlarmUsecase(
      alarm: alarm,
    );
    data.fold(
      (l) {
        emit(state.copyWith(errorMessage: l.message));
      },
      (r) {
        emit(
          state.copyWith(
            alarms: r,
            errorMessage: null,
          ),
        );
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  Future<void> updateAlarm({
    required AlarmEntity oldAlarm,
    required AlarmEntity newAlarm,
  }) async {
    Either<Failures, List<AlarmEntity>> data = await updateAlarmUsecase(
      oldAlarm: oldAlarm,
      newAlarm: newAlarm,
    );
    data.fold(
      (l) {
        emit(state.copyWith(errorMessage: l.message));
      },
      (r) {
        alarmsList = r;
        emit(
          state.copyWith(
            alarms: r,
            errorMessage: null,
          ),
        );
      },
    );
  }
}
