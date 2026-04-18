import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_permissions_repo.dart';

class GetAutoStartPermissionScreenUsecase {
  final AlarmPermissionsRepo alarmPermissionsRepo;
  GetAutoStartPermissionScreenUsecase({required this.alarmPermissionsRepo});

  Future<Either<Failures, Unit>> call() async {
    return alarmPermissionsRepo.getAutoStartPermissionSettingsScreen();
  }
}
