import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/alarm_repited.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/core/services/app_alarm_service.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_cubit/alarm_cubit.dart';

class DisplayAlarmScreen extends StatefulWidget {
  final AlarmSettings alarm;
  const DisplayAlarmScreen({super.key, required this.alarm});

  @override
  State<DisplayAlarmScreen> createState() => _DisplayAlarmScreenState();
}

class _DisplayAlarmScreenState extends State<DisplayAlarmScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, bottom: 22),
                child: FittedBox(
                  child: Text(
                    'Wake Up',
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 22.sp,
                      fontFamily: AppFonts.poppins,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.yellow),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:
                      Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Text(
                                  widget.alarm.dateTime.hour.toString().padLeft(
                                    2,
                                    '0',
                                  ),
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              FittedBox(
                                child: Text(
                                  ':',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              FittedBox(
                                child: Text(
                                  widget.alarm.dateTime.minute
                                      .toString()
                                      .padLeft(2, '0'),
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              FittedBox(
                                child: Text(
                                  'PM',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                          .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: false),
                          )
                          .shimmer(
                            duration: const Duration(milliseconds: 1400),
                            colors: [
                              Colors.grey,
                              Colors.yellow.shade200,
                              Colors.grey,
                            ],
                          ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0.h),
                child: Dismissible(
                  key: const Key('stop_alarm'),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) async {
                    // get alarms
                    await context.read<AlarmCubit>().getAlarms();
                    AlarmEntity alarm = context
                        .read<AlarmCubit>()
                        .state
                        .alarms
                        .firstWhere(
                          (element) =>
                              (int.parse(element.id) % 2147483647) ==
                              widget.alarm.id,
                        );
                    if (alarm.repited == AlarmRepited.once) {
                      await AppAlarmService.deleteAlarm(
                        id: widget.alarm.id,
                      );
                      // update alarm state
                      await context.read<AlarmCubit>().updateAlarm(
                        oldAlarm: alarm,
                        newAlarm: AlarmEntity(
                          hint: alarm.hint,
                          time: alarm.time,
                          repited: alarm.repited,
                          isActive: false,
                          id: alarm.id,
                        ),
                      );
                    } else {
                      // if alarm is repited
                      // اعادة تهييئة الوقت
                      final now = DateTime.now();
                      DateTime alarmTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        alarm.time.hour,
                        alarm.time.minute,
                      );
                      if (now.isAfter(alarmTime)) {
                        alarmTime = alarmTime.add(
                          const Duration(days: 1),
                        );
                      }
                      // create new time
                      TimeOfDay time = TimeOfDay(
                        hour: alarmTime.hour,
                        minute: alarmTime.minute,
                      );
                      // create new alarm
                      AlarmEntity newAlarm = AlarmEntity(
                        hint: alarm.hint,
                        time: time,
                        repited: alarm.repited,
                        isActive: alarm.isActive,
                        id: alarm.id,
                      );
                      // update alarm
                      await context.read<AlarmCubit>().updateAlarm(
                        oldAlarm: alarm,
                        newAlarm: newAlarm,
                      );
                    }

                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:
                        Text(
                              'Swipe To Stop >> ',
                              style: TextStyle(
                                fontFamily: AppFonts.poppins,
                                fontStyle: FontStyle.normal,
                                fontSize: 30.sp,
                                color: AppColors.black,
                              ),
                            )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .shimmer(
                              duration: const Duration(
                                milliseconds: 1400,
                              ),
                              colors: [
                                AppColors.black,
                                AppColors.yellow,
                                AppColors.black,
                              ],
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
