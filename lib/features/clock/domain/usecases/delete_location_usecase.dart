import 'package:g_lab/features/clock/domain/entities/location_entity.dart';
import 'package:g_lab/features/clock/domain/repositories/clock_repo.dart';

class DeleteLocationUsecase {
  final ClockRepo clockRepo;
  DeleteLocationUsecase({required this.clockRepo});

  Future<Set<LocationEntity>> call({required LocationEntity location}) async {
    return clockRepo.deleteLocation(location: location);
  }
}
