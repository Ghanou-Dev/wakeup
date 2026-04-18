import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:dartz/dartz.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_lab/core/errors/failures.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_app_info_screen_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_auto_start_permission_screen_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_device_name_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_disible_battery_optimization_screen_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_display_over_apps_settings_usecase.dart';
part 'alarm_permissions_state.dart';

class AlarmPermissionsCubit extends Cubit<AlarmPermissionsState> {
  final GetDisplayOverAppsSettingsUsecase getShowOnLockScreenSettingsUsecase;
  final GetAppInfoScreenUsecase getAppInfoScreenUsecase;
  final GetAutoStartPermissionScreenUsecase getAutoStartPermissionScreenUsecase;
  final GetDeviceNameUsecase getDeviceNameUsecase;
  final GetDisibleBatteryOptimizationScreenUsecase
  getDisibleBatteryOptimizationScreenUsecase;
  AlarmPermissionsCubit({
    required this.getShowOnLockScreenSettingsUsecase,
    required this.getAppInfoScreenUsecase,
    required this.getAutoStartPermissionScreenUsecase,
    required this.getDeviceNameUsecase,
    required this.getDisibleBatteryOptimizationScreenUsecase,
  }) : super(AlarmPermissionInitial());

  //////////////////////////////////////////////////////////////////////////////
  Future<void> openShowOnLockScreenPermission() async {
    Either<Failures, Unit> result = await getShowOnLockScreenSettingsUsecase();
    result.fold(
      (failure) {
        emit(AlarmPermissionFailure(message: failure.message));
      },
      (unit) {},
    );
  }
  //////////////////////////////////////////////////////////////////////////////

  Future<void> openDeviceSettings() async {
    const intent = AndroidIntent(action: 'android.settings.SETTINGS');
    await intent.launch();
  }

  Future<void> openAppInfoScreen() async {
    Either<Failures, Unit> result = await getAppInfoScreenUsecase();
    result.fold(
      (failure) {
        emit(AlarmPermissionFailure(message: failure.message));
      },
      (unit) {},
    );
  }

  Future<void> openAutoStartPermissionScreen() async {
    Either<Failures, Unit> result = await getAutoStartPermissionScreenUsecase();
    result.fold(
      (failure) {
        emit(AlarmPermissionFailure(message: failure.message));
      },
      (unit) {},
    );
  }

  Future<void> openDisibleBatteryOptimizationScreen() async {
    // Either<Failures, Unit> result =
    //     await getDisibleBatteryOptimizationScreenUsecase();
    // result.fold(
    //   (failure) {
    //     emit(AlarmPermissionFailure(message: failure.message));
    //   },
    //   (unit) {},
    // );

    bool isBatteryOptimizationDisabled =
        await DisableBatteryOptimization.isBatteryOptimizationDisabled ?? false;
    log('Battery optimatization : $isBatteryOptimizationDisabled');
    if (!isBatteryOptimizationDisabled) {
      await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
      log('Battery optimatization : tttrue');
    } else {
      log('Battery optimatization is Allowed');
    }
  }

  String? deviceName;

  Future<String> getDeviceName() async {
    Either<Failures, String?> result = await getDeviceNameUsecase();
    result.fold(
      (failure) {
        emit(AlarmPermissionFailure(message: failure.message));
      },
      (device) {
        return deviceName = device;
      },
    );
    return deviceName ?? '';
  }
}
