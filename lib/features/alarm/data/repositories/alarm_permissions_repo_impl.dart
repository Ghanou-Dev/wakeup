import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/exceptions.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/core/services/permissions_helper.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_permissions_repo.dart';

class AlarmPermissionsRepoImpl implements AlarmPermissionsRepo {
  @override
  Future<Either<Failures, Unit>> getAppInfoSettingsScreen() async {
    try {
      await PermissionsHelper.openAppInfoScreen();
      return const Right(unit);
    } on OpenAppInfoException catch (ex) {
      return Left(OpenAppInfoFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failures, Unit>> getAutoStartPermissionSettingsScreen() async {
    try {
      await PermissionsHelper.checkAutoStart();
      return const Right(unit);
    } on AutoStartException catch (ex) {
      return Left(AutoStartFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failures, String?>> getDeviceName() async {
    try {
      String? deviceName = await PermissionsHelper.getDeviceName();
      return Right(deviceName);
    } on GetDeviceNameException catch (ex) {
      return Left(GetDeviceNameFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failures, Unit>>
  getDisibleBatteryOptimizationSettingsScreen() async {
    try {
      await PermissionsHelper.ignoringBatteryOptimazation();
      return const Right(unit);
    } on IgnoreBatteryException catch (ex) {
      return Left(IgnorBatteryFailure(message: ex.message));
    }
  }

  @override
  Future<Either<Failures, Unit>> getDisplayOverAppsSettingsScreen() async {
    try {
      await PermissionsHelper.checkMiuiShowOnLockScreen();
      return const Right(unit);
    } catch (ex) {
      return Left(OpenOverAppsFailure(message: ex.toString()));
    }
  }
}
