import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:g_lab/features/clock/domain/entities/location_entity.dart';
import 'package:g_lab/features/clock/domain/usecases/add_location_usecase.dart';
import 'package:g_lab/features/clock/domain/usecases/delete_location_usecase.dart';
import 'package:g_lab/features/clock/domain/usecases/get_saved_location_usecase.dart';
import 'package:timezone/timezone.dart' as tz;
part 'clock_state.dart';

class ClockCubit extends Cubit<ClockState> {
  final AddLocationUsecase addLocationUsecase;
  final DeleteLocationUsecase deleteLocationUsecase;
  final GetSavedLocationsUsecase getSavedLocationsUsecase;
  ClockCubit({
    required this.addLocationUsecase,
    required this.deleteLocationUsecase,
    required this.getSavedLocationsUsecase,
  }) : super(
         ClockState(
           savedLocations: {},
           allLocations: [],
           currentLocation: tz.local,
         ),
       ) {
    getAllLocations();
    intLocalTZDateTime();
  }

  Timer? timer;

  // تهيئة الوقت الحالي للمنطقة الزمنية الخاصة بالجهاز
  Future<void> intLocalTZDateTime() async {
    TimezoneInfo tzInfo = await FlutterTimezone.getLocalTimezone();
    tz.Location location = tz.getLocation(tzInfo.identifier);
    tz.setLocalLocation(location);
    emit(state.copyWith(currentLocation: tz.local));
  }

  // جلب جميع المناطق الزمنية
  Future<void> getAllLocations() async {
    List<tz.Location> locations = tz.timeZoneDatabase.locations.values.toList();
    Set<LocationEntity> savedLocations = await getSavedLocationsUsecase.call();
    Set<tz.Location> allSavedLocations = savedLocations
        .map((e) => tz.getLocation(e.locationName))
        .toSet();
    emit(
      state.copyWith(
        allLocations: locations,
        savedLocations: allSavedLocations,
      ),
    );
  }

  // اضافة منطقة زمنية
  Future<void> saveLocation({required tz.Location location}) async {
    Set<tz.Location> updateLocations = Set<tz.Location>.from(
      state.savedLocations,
    )..add(location);

    await addLocationUsecase(
      location: LocationEntity(locationName: location.name),
    );

    emit(state.copyWith(savedLocations: updateLocations));
  }

  // حذف منطقة زمنية
  Future<void> deleteLocation({required tz.Location location}) async {
    Set<tz.Location> updateLocations = Set<tz.Location>.from(
      state.savedLocations,
    )..remove(location);
    await deleteLocationUsecase(
      location: LocationEntity(locationName: location.name),
    );
    emit(state.copyWith(savedLocations: updateLocations));
  }
}
