import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_lab/features/stopwatch/domain/entities/lap_entity.dart';
import 'package:g_lab/features/stopwatch/domain/services/stopwatch_service.dart';
part 'stopwatch_state.dart';

class StopwatchCubit extends Cubit<StopwatchState> {
  final StopwatchService stopwatchService;
  StopwatchCubit({
    required this.stopwatchService,
  }) : super(
         StopwatchState(
           time: '00 : 00 : 00',
           isRunning: false,
           isPaused: false,
           laps: [],
         ),
       );
  Timer? timer;
  //////////////////////////////////////////////////////////////////////////////

  void start() {
    timer?.cancel();
    stopwatchService.start();
    timer = Timer.periodic(
      const Duration(milliseconds: 30),
      (time) {
        if (stopwatchService.checkOverTime()) {
          reset();
          return;
        }
        update();
        emit(state.copyWith(isRunning: true, isPaused: false));
      },
    );
  }

  void pause() {
    timer?.cancel();
    stopwatchService.pause();
    emit(state.copyWith(isRunning: false, isPaused: true));
  }

  void resume() {
    stopwatchService.resume();
    timer = Timer.periodic(
      const Duration(milliseconds: 30),
      (time) {
        update();
        emit(state.copyWith(isRunning: true, isPaused: false));
      },
    );
  }

  void reset() {
    timer?.cancel();
    stopwatchService.reset();
    String time = stopwatchService.update();
    emit(
      state.copyWith(isRunning: false, isPaused: false, time: time, laps: []),
    );
  }

  void update() {
    String time = stopwatchService.update();
    emit(state.copyWith(time: time));
  }

  void getLaps() {
    List<LapEntity> lapps = stopwatchService.getLap(laps: state.laps);
    emit(state.copyWith(laps: lapps));
  }
}
