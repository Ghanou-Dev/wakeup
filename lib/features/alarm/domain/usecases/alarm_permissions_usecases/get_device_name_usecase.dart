import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_permissions_repo.dart';

class GetDeviceNameUsecase {
  final AlarmPermissionsRepo alarmPermissionsRepo;
  GetDeviceNameUsecase({required this.alarmPermissionsRepo});

  Future<Either<Failures, String?>> call() async {
    return alarmPermissionsRepo.getDeviceName();
  }
}
