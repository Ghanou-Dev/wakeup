import 'package:g_lab/features/clock/domain/entities/location_entity.dart';
import 'package:g_lab/features/clock/domain/repositories/clock_repo.dart';

class GetSavedLocationsUsecase {
  final ClockRepo clockRepo;
  GetSavedLocationsUsecase({required this.clockRepo});

  Future<Set<LocationEntity>> call() async {
    return clockRepo.getSavedLocation();
  }
}
