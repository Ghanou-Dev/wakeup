import 'package:dartz/dartz.dart';
import 'package:g_lab/core/errors/failures.dart';

abstract class AlarmPermissionsRepo {
  Future<Either<Failures, String?>> getDeviceName();
  Future<Either<Failures, Unit>> getAutoStartPermissionSettingsScreen();
  Future<Either<Failures, Unit>> getDisibleBatteryOptimizationSettingsScreen();
  Future<Either<Failures, Unit>> getAppInfoSettingsScreen();
  Future<Either<Failures, Unit>> getDisplayOverAppsSettingsScreen();
}
