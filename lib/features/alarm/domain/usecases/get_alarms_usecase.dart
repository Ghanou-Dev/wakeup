import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_repositories.dart';

class GetAlarmsUsecase {
  final AlarmRepositories alarmRepo;
  GetAlarmsUsecase({required this.alarmRepo});

  Future<Either<Failures, List<AlarmEntity>>> call() async {
    return await alarmRepo.getAlarms();
  }
}
