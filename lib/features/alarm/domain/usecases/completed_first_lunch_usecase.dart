import 'package:g_lab/features/alarm/domain/repositories/alarm_repositories.dart';

class CompletedFirstLunchUsecase {
  final AlarmRepositories alarmRepo;
  CompletedFirstLunchUsecase({required this.alarmRepo});

  Future<void> call() async {
    alarmRepo.complatedFirstLunch();
  }
}
