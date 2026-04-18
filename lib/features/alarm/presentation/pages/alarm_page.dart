import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/core/services/app_alarm_service.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_cubit/alarm_cubit.dart';
import 'package:g_lab/features/alarm/presentation/widgets/alarm_item.dart';
import 'package:g_lab/features/alarm/presentation/widgets/helper/pick_time_helper.dart';
import 'package:g_lab/features/alarm/presentation/widgets/helper/show_bottom_sheet_helper.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  TimeOfDay timeNow = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text(
          'Alarm',
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            color: AppColors.white,
          ),
        ),

        ///! this for the next version inchaa allah //////////////////////////////////////////////////
        // actions: [
        //   PopupMenuButton(
        //     color: AppColors.white,
        //     iconColor: AppColors.white,
        //     itemBuilder: (context) {
        //       return [
        //         PopupMenuItem(
        //           onTap: () async {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                 builder: (context) => DisplayAlarmScreen(
        //                   alarm: AlarmSettings(
        //                     id: 22,
        //                     dateTime: DateTime(2026),
        //                     volumeSettings: VolumeSettings.fade(
        //                       fadeDuration: const Duration(seconds: 4),
        //                     ),
        //                     notificationSettings: const NotificationSettings(
        //                       title: 'title',
        //                       body: 'body',
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             );
        //           },
        //           value: 'settings',
        //           child: const Text(
        //             'Settings',
        //             style: TextStyle(
        //               fontFamily: AppFonts.poppins,
        //               color: AppColors.black,
        //             ),
        //           ),
        //         ),
        //       ];
        //     },
        //   ),
        // ],
        ///////////////////////////////////////////////////////////////////////////////////////////
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: AppColors.yellow,
        elevation: 0,
        // FloatingActionButton : Add New Alarm
        onPressed: () async {
          showBottomSheetHepler(context);
        },
        child: const Icon(
          Icons.add,
          color: AppColors.deepGrey,
        ),
      ),
      body: BlocBuilder<AlarmCubit, AlarmState>(
        builder: (context, state) {
          List<AlarmEntity> alarms = state.alarms;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: alarms.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  // Edit Alarm Item
                  onTap: () async {
                    TimeOfDay? timePicked = await pickTimeHepler(
                      context: context,
                      initTime: timeNow,
                    );
                    if (timePicked != null && timeNow != timePicked) {
                      // delete old alarm
                      await AppAlarmService.deleteAlarm(
                        id: int.parse(alarms[index].id) % 2147483647,
                      );
                      // update alarm
                      await context.read<AlarmCubit>().updateAlarm(
                        oldAlarm: AlarmEntity(
                          hint: alarms[index].hint,
                          time: alarms[index].time,
                          repited: alarms[index].repited,
                          isActive: alarms[index].isActive,
                          id: alarms[index].id,
                        ),
                        newAlarm: AlarmEntity(
                          hint: alarms[index].hint,
                          time: timePicked,
                          repited: alarms[index].repited,
                          isActive: alarms[index].isActive,
                          id: alarms[index].id,
                        ),
                      );

                      // get the deffrence betwin alarmTime and current time
                      final now = DateTime.now();
                      DateTime alarmDateTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        timePicked.hour,
                        timePicked.minute,
                      );
                      if (now.isAfter(alarmDateTime)) {
                        alarmDateTime = alarmDateTime.add(
                          const Duration(days: 1),
                        );
                      }
                      // start new alarm
                      await AppAlarmService.createAlarm(
                        alarmEntity: AlarmEntity(
                          hint: alarms[index].hint,
                          time: timePicked,
                          repited: alarms[index].repited,
                          isActive: alarms[index].isActive,
                          id: alarms[index].id,
                        ),
                        dateTime: alarmDateTime,
                        vibrate: true,
                      );
                    }
                  },
                  // Show dialog delete item
                  onLongPress: () async {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      buttonsBorderRadius: BorderRadius.circular(20),
                      dismissOnTouchOutside: true,
                      dismissOnBackKeyPress: true,
                      headerAnimationLoop: false,
                      dialogBackgroundColor: AppColors.black,
                      title: 'Delete',
                      titleTextStyle: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                        color: AppColors.white,
                      ),
                      desc: 'Are You Sure You Want To Delete This Alarm',
                      descTextStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18.sp,
                        color: AppColors.white,
                      ),
                      btnCancel: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      btnOk: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          foregroundColor: AppColors.black,
                        ),
                        onPressed: () async {
                          await context.read<AlarmCubit>().deleteAlarm(
                            alarm: alarms[index],
                          );
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Ok',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ).show();
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: AlarmItem(
                    hint: alarms[index].hint,
                    repited: alarms[index].repited,
                    time: alarms[index].time,
                    isActive: alarms[index].isActive,
                    id: alarms[index].id,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
