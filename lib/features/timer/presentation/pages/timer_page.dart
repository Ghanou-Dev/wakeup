import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/features/timer/presentation/cubits/timer_cubit.dart';
import 'package:g_lab/features/timer/presentation/helper/time_is.dart';
import 'package:g_lab/features/timer/presentation/widgets/pick_duration.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.black,
        title: const Text(
          'Timer',
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            color: AppColors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Hour',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Minute',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Second',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              ////////////////////////////////////////////////////////////////////
              Container(
                decoration: BoxDecoration(
                  color: AppColors.deepGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PickDuration(
                        timeIs: TimeIs.hour,
                        maxLen: 12,
                        onChanged: (value) {
                          context.read<TimerCubit>().updateDuration(
                            hours: value,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      PickDuration(
                        timeIs: TimeIs.minute,
                        maxLen: 60,
                        onChanged: (value) {
                          context.read<TimerCubit>().updateDuration(
                            minutes: value,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ':',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      PickDuration(
                        timeIs: TimeIs.second,
                        maxLen: 60,
                        onChanged: (value) {
                          context.read<TimerCubit>().updateDuration(
                            secondes: value,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              ////////////////////////////////////////////////////////////////////
              Center(
                child: BlocBuilder<TimerCubit, TimerState>(
                  builder: (context, state) {
                    int hour = state.duration.inHours;
                    int minute = (state.duration.inSeconds % 3600) ~/ 60;
                    int second = state.duration.inSeconds % 60;
                    return state.ringing
                        ? Text(
                                '${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')}',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shimmer(
                                duration: const Duration(milliseconds: 1300),
                                colors: [
                                  AppColors.greyy,
                                  AppColors.yellow,
                                  AppColors.greyy,
                                  AppColors.yellow,
                                  AppColors.greyy,
                                ],
                              )
                        : Text(
                            '${hour.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontFamily: AppFonts.poppins,
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      backgroundColor: AppColors.deepGrey,
                      fixedSize: Size(124.w, 52.h),
                    ),
                    onPressed: () async {
                      await context.read<TimerCubit>().resetTimer();
                    },
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BlocBuilder<TimerCubit, TimerState>(
                    buildWhen: (previous, current) =>
                        previous.isRun != current.isRun,
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.black,
                          backgroundColor: AppColors.yellow,
                          fixedSize: Size(124.w, 52.h),
                        ),
                        onPressed: () {
                          if (state.isRun) {
                            context.read<TimerCubit>().pauseTimer();
                          } else {
                            context.read<TimerCubit>().startTimer();
                          }
                        },
                        child: Text(
                          state.isRun ? 'Pause' : 'Start',
                          style: const TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
