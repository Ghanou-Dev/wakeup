import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_repositories.dart';

class DeleteAlarmUsecase {
  final AlarmRepositories alarmRepo;
  DeleteAlarmUsecase({required this.alarmRepo});

  Future<Either<Failures, List<AlarmEntity>>> call({
    required AlarmEntity alarm,
  }) async {
    return await alarmRepo.deleteAlarm(alarm: alarm);
  }
}
