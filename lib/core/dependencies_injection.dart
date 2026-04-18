import 'dart:async';

import 'package:g_lab/core/services/app_audio_service.dart';
import 'package:g_lab/features/alarm/data/datasource/alarm_locale_datasource.dart';
import 'package:g_lab/features/alarm/data/models/alarm_model.dart';
import 'package:g_lab/features/alarm/data/repositories/alarm_permissions_repo_impl.dart';
import 'package:g_lab/features/alarm/data/repositories/alarm_repo_impl.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_permissions_repo.dart';
import 'package:g_lab/features/alarm/domain/repositories/alarm_repositories.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_app_info_screen_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_auto_start_permission_screen_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_device_name_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_disible_battery_optimization_screen_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/alarm_permissions_usecases/get_display_over_apps_settings_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/completed_first_lunch_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/delete_alarm_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/get_alarms_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/is_first_lunch_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/save_alarm_usecase.dart';
import 'package:g_lab/features/alarm/domain/usecases/update_alarm_usecase.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_cubit/alarm_cubit.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_permissions_cubit/alarm_permissions_cubit.dart';
import 'package:g_lab/features/clock/data/data_sources/clock_local_datasource.dart';
import 'package:g_lab/features/clock/data/models/location_model.dart';
import 'package:g_lab/features/clock/data/repositories/clock_repo_impl.dart';
import 'package:g_lab/features/clock/domain/repositories/clock_repo.dart';
import 'package:g_lab/features/clock/domain/usecases/add_location_usecase.dart';
import 'package:g_lab/features/clock/domain/usecases/delete_location_usecase.dart';
import 'package:g_lab/features/clock/domain/usecases/get_saved_location_usecase.dart';
import 'package:g_lab/features/clock/presentation/cubits/clock_cubit.dart';
import 'package:g_lab/features/stopwatch/data/services/stopwatch_service_impl.dart';
import 'package:g_lab/features/stopwatch/domain/services/stopwatch_service.dart';
import 'package:g_lab/features/stopwatch/presentation/cubits/stopwatch_cubit.dart';
import 'package:g_lab/features/timer/presentation/cubits/timer_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Clock
  // cubit
  sl.registerFactory<ClockCubit>(
    () => ClockCubit(
      addLocationUsecase: sl<AddLocationUsecase>(),
      deleteLocationUsecase: sl<DeleteLocationUsecase>(),
      getSavedLocationsUsecase: sl<GetSavedLocationsUsecase>(),
    ),
  );
  // usecases
  sl.registerLazySingleton<AddLocationUsecase>(
    () => AddLocationUsecase(clockRepo: sl<ClockRepo>()),
  );
  sl.registerLazySingleton<DeleteLocationUsecase>(
    () => DeleteLocationUsecase(clockRepo: sl<ClockRepo>()),
  );
  sl.registerLazySingleton<GetSavedLocationsUsecase>(
    () => GetSavedLocationsUsecase(clockRepo: sl<ClockRepo>()),
  );
  // repositories
  sl.registerLazySingleton<ClockRepo>(
    () => ClockRepoImpl(datasource: sl<ClockLocalDatasource>()),
  );
  // data sources
  sl.registerLazySingleton<ClockLocalDatasource>(
    () => ClockLocalDataSourceWithHive(locationsBox: sl<Box<LocationModel>>()),
  );
  // box
  Box<LocationModel> locationBox = await Hive.openBox<LocationModel>(
    'locationBox',
  );
  sl.registerLazySingleton<Box<LocationModel>>(() => locationBox);
  //! timer
  sl.registerFactory<TimerCubit>(
    () => TimerCubit(appAudioService: sl<AppAudioService>()),
  );
  // services
  sl.registerLazySingleton<AppAudioService>(
    () => AppAudioService(),
  );
  //! stopwatch
  // Cubit
  sl.registerFactory<StopwatchCubit>(
    () => StopwatchCubit(stopwatchService: sl<StopwatchService>()),
  );
  // Services
  sl.registerLazySingleton<StopwatchService>(
    () => StopwatchServiceImpl(stopwatch: sl<Stopwatch>()),
  );
  //
  sl.registerLazySingleton<Stopwatch>(
    () => Stopwatch(),
  );
  //! alarm
  // bloc
  sl.registerFactory<AlarmPermissionsCubit>(
    () => AlarmPermissionsCubit(
      getShowOnLockScreenSettingsUsecase:
          sl<GetDisplayOverAppsSettingsUsecase>(),
      getAppInfoScreenUsecase: sl<GetAppInfoScreenUsecase>(),
      getAutoStartPermissionScreenUsecase:
          sl<GetAutoStartPermissionScreenUsecase>(),
      getDeviceNameUsecase: sl<GetDeviceNameUsecase>(),
      getDisibleBatteryOptimizationScreenUsecase:
          sl<GetDisibleBatteryOptimizationScreenUsecase>(),
    ),
  );
  // usecases
  sl.registerLazySingleton<GetDisplayOverAppsSettingsUsecase>(
    () => GetDisplayOverAppsSettingsUsecase(
      alarmPermissionsRepo: sl<AlarmPermissionsRepo>(),
    ),
  );
  sl.registerLazySingleton<GetAppInfoScreenUsecase>(
    () => GetAppInfoScreenUsecase(
      alarmPermissionsRepo: sl<AlarmPermissionsRepo>(),
    ),
  );
  sl.registerLazySingleton<GetAutoStartPermissionScreenUsecase>(
    () => GetAutoStartPermissionScreenUsecase(
      alarmPermissionsRepo: sl<AlarmPermissionsRepo>(),
    ),
  );
  sl.registerLazySingleton<GetDeviceNameUsecase>(
    () => GetDeviceNameUsecase(
      alarmPermissionsRepo: sl<AlarmPermissionsRepo>(),
    ),
  );
  sl.registerLazySingleton<GetDisibleBatteryOptimizationScreenUsecase>(
    () => GetDisibleBatteryOptimizationScreenUsecase(
      alarmPermissionsRepo: sl<AlarmPermissionsRepo>(),
    ),
  );

  // repositories
  sl.registerLazySingleton<AlarmPermissionsRepo>(
    () => AlarmPermissionsRepoImpl(),
  );

  // bloc
  sl.registerFactory<AlarmCubit>(
    () => AlarmCubit(
      getAlarmsUsecase: sl<GetAlarmsUsecase>(),
      saveAlarmUsecase: sl<SaveAlarmUsecase>(),
      deleteAlarmUsecase: sl<DeleteAlarmUsecase>(),
      updateAlarmUsecase: sl<UpdateAlarmUsecase>(),
      isFirstLunchUsecase: sl<IsFirstLunchUsecase>(),
      completedFirstLunchUsecase: sl<CompletedFirstLunchUsecase>(),
    ),
  );
  // usecases
  sl.registerLazySingleton<GetAlarmsUsecase>(
    () => GetAlarmsUsecase(alarmRepo: sl<AlarmRepositories>()),
  );
  sl.registerLazySingleton<SaveAlarmUsecase>(
    () => SaveAlarmUsecase(alarmRepo: sl<AlarmRepositories>()),
  );
  sl.registerLazySingleton<DeleteAlarmUsecase>(
    () => DeleteAlarmUsecase(alarmRepo: sl<AlarmRepositories>()),
  );
  sl.registerLazySingleton<UpdateAlarmUsecase>(
    () => UpdateAlarmUsecase(alarmRepo: sl<AlarmRepositories>()),
  );
  sl.registerLazySingleton(
    () => IsFirstLunchUsecase(alarmRepositories: sl<AlarmRepositories>()),
  );
  sl.registerLazySingleton(
    () => CompletedFirstLunchUsecase(alarmRepo: sl<AlarmRepositories>()),
  );
  // repositories
  sl.registerLazySingleton<AlarmRepositories>(
    () => AlarmRepoImpl(alarmLocaleDatasource: sl<AlarmLocaleDatasource>()),
  );
  // local data base
  sl.registerLazySingleton<AlarmLocaleDatasource>(
    () => AlarmLocaleDatasource(
      boxAlarms: sl<Box<AlarmModel>>(),
      isFirstLunchBox: sl<Box<bool>>(),
    ),
  );
  // box
  Box<AlarmModel> alarmBox = await Hive.openBox<AlarmModel>('alarmBox');
  sl.registerLazySingleton<Box<AlarmModel>>(
    () => alarmBox,
  );
  Box<bool> isFirstLunchBox = await Hive.openBox<bool>('isFirstLunch');
  sl.registerLazySingleton(
    () => isFirstLunchBox,
  );
}
