import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_lab/core/services/app_audio_service.dart';
part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  final AppAudioService appAudioService;
  TimerCubit({required this.appAudioService})
    : super(
        TimerState(
          isRun: false,
          ringing: false,
          duration: Duration.zero,
          hour: 0,
          minute: 0,
          second: 0,
        ),
      );

  Timer? timer;
  int totalSeconds = 0;
  //////////////////////////////////////////////////////////////////////////////
  int selectedHour = 0;
  int selectedMinute = 0;
  int selectedSecond = 0;

  Future<void> ringing() async {
    await appAudioService.play();
  }

  void updateDuration({int? hours, int? minutes, int? secondes}) {
    /// حفظ القيم التي تم اختيارها من العداد
    selectedHour = hours ?? state.hour;
    selectedMinute = minutes ?? minutes ?? state.minute;
    selectedSecond = secondes ?? secondes ?? state.second;
    emit(
      state.copyWith(
        hour: hours ?? state.hour,
        minute: minutes ?? state.minute,
        second: secondes ?? state.second,
      ),
    );
  }

  void startTimer() {
    totalSeconds = (state.hour * 3600) + (state.minute * 60) + (state.second);
    timer?.cancel();
    Duration duration = Duration(
      hours: totalSeconds ~/ 3600,
      minutes: (totalSeconds % 3600) ~/ 60,
      seconds: totalSeconds % 60,
    );
    emit(
      state.copyWith(
        isRun: true,
        duration: duration,
        hour: totalSeconds ~/ 3600,
        minute: (totalSeconds % 3600) ~/ 60,
        second: totalSeconds % 60,
      ),
    );
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (totalSeconds == 0) {
        timer?.cancel();
        ringing();
        emit(
          state.copyWith(
            isRun: false,
            ringing: true,
            duration: Duration.zero,
          ),
        );
      } else {
        totalSeconds -= 1;
        Duration duration = Duration(
          hours: totalSeconds ~/ 3600,
          minutes: (totalSeconds % 3600) ~/ 60,
          seconds: totalSeconds % 60,
        );
        emit(
          state.copyWith(
            isRun: true,
            duration: duration,
          ),
        );
      }
    });
  }

  void pauseTimer() {
    timer?.cancel();

    emit(
      state.copyWith(
        isRun: false,
        // ارسال القيم التي تم النقص منها لكي يمكل العد من حيث توقف
        hour: totalSeconds ~/ 3600,
        minute: (totalSeconds % 3600) ~/ 60,
        second: totalSeconds % 60,
      ),
    );
  }

  Future<void> resetTimer() async {
    timer?.cancel();
    await appAudioService.stop();
    emit(
      state.copyWith(
        duration: Duration.zero,
        isRun: false,
        ringing: false,
        // اعادة ارسال القيم المحفوضة للعداد
        hour: selectedHour,
        minute: selectedMinute,
        second: selectedSecond,
      ),
    );
  }
}
