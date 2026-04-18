import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';

abstract class AlarmRepositories {
  Future<Either<Failures, List<AlarmEntity>>> getAlarms();
  Future<Either<Failures, List<AlarmEntity>>> saveAlarm({
    required AlarmEntity alarm,
  });
  Future<Either<Failures, List<AlarmEntity>>> deleteAlarm({
    required AlarmEntity alarm,
  });
  Future<Either<Failures, List<AlarmEntity>>> updateAlarm({
    required AlarmEntity oldAlarm,
    required AlarmEntity newAlarm,
  });
  Future<bool> isFirstLunch();
  Future<void> complatedFirstLunch();
}
