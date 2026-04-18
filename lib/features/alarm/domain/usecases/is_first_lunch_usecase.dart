import 'package:g_lab/features/alarm/domain/repositories/alarm_repositories.dart';

class IsFirstLunchUsecase {
  final AlarmRepositories alarmRepositories;
  IsFirstLunchUsecase({required this.alarmRepositories});

  Future<bool> call() async {
    return alarmRepositories.isFirstLunch();
  }
}
