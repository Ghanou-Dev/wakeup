import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/features/stopwatch/presentation/cubits/stopwatch_cubit.dart';
import 'package:g_lab/features/stopwatch/presentation/widgets/lap_item.dart';
import 'package:g_lab/core/dependencies_injection.dart' as dl;

class StopwatchPage extends StatelessWidget {
  const StopwatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dl.sl<StopwatchCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          scrolledUnderElevation: 0,
          title: const FittedBox(
            child: Text(
              'Stopwatch',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 36.0.w,
                        vertical: 20.h,
                      ),
                      child: BlocBuilder<StopwatchCubit, StopwatchState>(
                        builder: (context, state) {
                          // counter not running
                          if (state.isRunning == false &&
                              state.isPaused == false) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    '00',
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontSize: 44.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                FittedBox(
                                  child: Text(
                                    ':',
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontSize: 44.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                FittedBox(
                                  child: Text(
                                    '00',
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontSize: 44.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                FittedBox(
                                  child: Text(
                                    ':',
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontSize: 44.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                FittedBox(
                                  child: Text(
                                    '00',
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontSize: 44.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                            // stopwatch paused
                          } else if (state.isRunning == false &&
                              state.isPaused == true) {
                            return FittedBox(
                              child: Text(
                                state.time,
                                style: TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontSize: 44.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            );
                            // stopwatch running
                          } else if (state.isRunning == true &&
                              state.isPaused == false) {
                            return FittedBox(
                              child: Text(
                                state.time,
                                style: TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontSize: 44.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          } else {
                            return FittedBox(
                              child: Text(
                                state.time,
                                style: TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontSize: 44.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    BlocBuilder<StopwatchCubit, StopwatchState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.deepGrey,
                                foregroundColor: AppColors.white,
                                fixedSize: Size(124.w, 52.h),
                              ),
                              onPressed: () {
                                // Lap button
                                if (state.isRunning == true) {
                                  context.read<StopwatchCubit>().getLaps();
                                } else {
                                  context.read<StopwatchCubit>().reset();
                                }
                              },
                              child: FittedBox(
                                child: Text(
                                  state.isPaused ? 'Reset' : 'Lap',
                                  style: const TextStyle(
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.yellow,
                                foregroundColor: AppColors.black,
                                fixedSize: Size(124.w, 52.h),
                              ),
                              onPressed: () {
                                // start button
                                if (state.isRunning == false) {
                                  print('======> start');
                                  context.read<StopwatchCubit>().start();
                                } else {
                                  print('======> pause');
                                  context.read<StopwatchCubit>().pause();
                                }
                              },
                              child: FittedBox(
                                child: Text(
                                  state.isRunning ? 'Pause' : 'Start',
                                  style: const TextStyle(
                                    fontFamily: AppFonts.poppins,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    BlocBuilder<StopwatchCubit, StopwatchState>(
                      builder: (context, state) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.laps.length,
                          itemBuilder: (context, index) {
                            return LapItem(
                              index: index + 1,
                              time: state.laps[index].time,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
