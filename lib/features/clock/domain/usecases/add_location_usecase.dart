import 'package:g_lab/features/clock/domain/entities/location_entity.dart';
import 'package:g_lab/features/clock/domain/repositories/clock_repo.dart';

class AddLocationUsecase {
  final ClockRepo clockRepo;
  AddLocationUsecase({required this.clockRepo});
  Future<Set<LocationEntity>> call({required LocationEntity location}) async {
    return clockRepo.addLocation(location: location);
  }
}
