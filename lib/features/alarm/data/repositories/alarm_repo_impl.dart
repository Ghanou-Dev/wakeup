import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/exceptions.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/data/datasource/alarm_locale_datasource.dart';
import 'package:g_lab/features/alarm/data/models/alarm_model.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_repositories.dart';

class AlarmRepoImpl implements AlarmRepositories {
  final AlarmLocaleDatasource alarmLocaleDatasource;
  AlarmRepoImpl({required this.alarmLocaleDatasource});

  @override
  Future<Either<Failures, List<AlarmEntity>>> saveAlarm({
    required AlarmEntity alarm,
  }) async {
    final AlarmModel alarmModel = AlarmModel.fromEntity(alarm);
    try {
      List<AlarmModel> alarms = await alarmLocaleDatasource.saveAlarm(
        alarm: alarmModel,
      );
      List<AlarmEntity> entityAlarms = alarms.map((e) => e.toEntity()).toList();
      return Right(entityAlarms);
    } on UnsavedException catch (e) {
      return Left(UnsavedFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failures, List<AlarmEntity>>> getAlarms() async {
    try {
      List<AlarmModel> alarms = await alarmLocaleDatasource.getAlarms();
      List<AlarmEntity> entityAlarms = alarms.map((e) => e.toEntity()).toList();
      return Right(entityAlarms);
    } on GetAlarmsException catch (e) {
      return Left(GetAlarmsFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failures, List<AlarmEntity>>> deleteAlarm({
    required AlarmEntity alarm,
  }) async {
    try {
      List<AlarmModel> alarms = await alarmLocaleDatasource.deleteAlarm(
        alarm: AlarmModel.fromEntity(alarm),
      );
      List<AlarmEntity> entityAlarms = alarms.map((e) => e.toEntity()).toList();

      return Right(entityAlarms);
    } on DeleteAlarmException catch (e) {
      return Left(DeleteAlarmFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failures, List<AlarmEntity>>> updateAlarm({
    required AlarmEntity oldAlarm,
    required AlarmEntity newAlarm,
  }) async {
    try {
      List<AlarmModel> alarms = await alarmLocaleDatasource.updateAlarm(
        oldAlarm: AlarmModel.fromEntity(oldAlarm),
        newAlarm: AlarmModel.fromEntity(newAlarm),
      );
      List<AlarmEntity> entityAlarms = alarms.map((e) => e.toEntity()).toList();
      return Right(entityAlarms);
    } on UpdateAlarmException catch (e) {
      return Left(UpdateAlarmFailure(message: e.message));
    }
  }

  // check first lunch
  @override
  Future<bool> isFirstLunch() {
    return alarmLocaleDatasource.isFirstLunch();
  }

  @override
  Future<void> complatedFirstLunch() async {
    await alarmLocaleDatasource.copmlitedFirstLunch();
  }
}
