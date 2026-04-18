import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_repositories.dart';

class UpdateAlarmUsecase {
  final AlarmRepositories alarmRepo;
  UpdateAlarmUsecase({required this.alarmRepo});

  Future<Either<Failures, List<AlarmEntity>>> call({
    required AlarmEntity oldAlarm,
    required AlarmEntity newAlarm,
  }) async {
    return await alarmRepo.updateAlarm(oldAlarm: oldAlarm, newAlarm: newAlarm);
  }
}
