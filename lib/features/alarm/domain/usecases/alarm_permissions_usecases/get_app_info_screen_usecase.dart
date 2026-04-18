import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_permissions_repo.dart';

class GetAppInfoScreenUsecase {
  final AlarmPermissionsRepo alarmPermissionsRepo;
  GetAppInfoScreenUsecase({required this.alarmPermissionsRepo});

  Future<Either<Failures, Unit>> call() async {
    return alarmPermissionsRepo.getAppInfoSettingsScreen();
  }
}
