import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/alarm_repited.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/core/services/app_alarm_service.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_cubit/alarm_cubit.dart';
import 'package:g_lab/features/alarm/presentation/widgets/helper/pick_time_helper.dart';

class CustomBottomSheetBody extends StatefulWidget {
  const CustomBottomSheetBody({super.key});

  @override
  State<CustomBottomSheetBody> createState() => _CustomBottomSheetBodyState();
}

class _CustomBottomSheetBodyState extends State<CustomBottomSheetBody> {
  TimeOfDay timePicked = TimeOfDay.now();
  TextEditingController textController = TextEditingController();

  AlarmRepited? selectedItem = AlarmRepited.once;
  bool allowVibrate = true;
  bool deleteAfterGoesOff = false;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650.h,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 18.0,
            left: 14,
            right: 14,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Add Alarm',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      color: AppColors.white,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: textController,
                  cursorColor: AppColors.white,
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),

                    hintText: 'Add Hint',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  final time = await pickTimeHepler(
                    context: context,
                    initTime: timePicked,
                  );
                  if (time != null && time != timePicked) {
                    setState(() {
                      timePicked = time;
                    });
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(20),
                    border: BoxBorder.all(color: AppColors.yellow),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            timePicked
                                .format(context)
                                .split(':')[0]
                                .padLeft(2, '0'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.yellow,
                              fontSize: 46.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ':',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: AppFonts.poppins,
                              color: AppColors.yellow,
                              fontSize: 36.sp,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            timePicked
                                .format(context)
                                .split(':')[1]
                                .replaceAll(RegExp(r'(pm|PM|am|AM)'), ''),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.yellow,
                              fontSize: 46.sp,
                            ),
                          ),
                        ),
                        Text(
                          timePicked.period.name.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.yellow,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              // vibrate when alarm sounds
              SwitchListTile(
                activeTrackColor: AppColors.yellow,
                activeThumbColor: AppColors.deepGrey,
                title: Text(
                  'Vibrate when alarm sounds',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColors.white,
                  ),
                ),
                value: allowVibrate,
                onChanged: (value) {
                  setState(() {
                    allowVibrate = value;
                  });
                },
              ),
              // delete after goes off
              SwitchListTile(
                activeTrackColor: AppColors.yellow,
                activeThumbColor: AppColors.deepGrey,
                title: Text(
                  'Delete after goes off',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColors.white,
                  ),
                ),
                value: deleteAfterGoesOff,
                onChanged: (value) {
                  setState(() {
                    deleteAfterGoesOff = value;
                  });
                },
              ),
              // Repeat
              ListTile(
                title: Text(
                  'Repeted',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColors.white,
                  ),
                ),
                trailing: DropdownButton<AlarmRepited>(
                  dropdownColor: AppColors.black,
                  value: selectedItem,
                  style: const TextStyle(
                    color: AppColors.white,
                  ),
                  items: [
                    DropdownMenuItem<AlarmRepited>(
                      value: AlarmRepited.once,
                      child: const Text(
                        'Once',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {},
                    ),
                    DropdownMenuItem<AlarmRepited>(
                      value: AlarmRepited.evryday,
                      child: const Text(
                        'Everyday',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 30,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        //
                        AlarmEntity alarmEntity = AlarmEntity(
                          hint: textController.text.isEmpty
                              ? 'Wake up'
                              : textController.text,
                          time: timePicked,
                          repited: selectedItem ?? AlarmRepited.once,
                          isActive: true,
                          id: '${DateTime.now().microsecondsSinceEpoch}',
                        );
                        //
                        await context.read<AlarmCubit>().saveAlarm(
                          alarm: alarmEntity,
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
                          alarmDateTime = alarmDateTime.add(const Duration(days: 1));
                        }
                        //set alarm
                        // من غير المنظم وضع هذه الدالة هنا و لكنني اشعر بالكسل , سأعدلها لاحقا
                        await AppAlarmService.createAlarm(
                          alarmEntity: alarmEntity,
                          dateTime: alarmDateTime,
                          vibrate: allowVibrate,
                        );
                        // go back
                        Navigator.of(context).pop();
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                      ),
                      icon: const Icon(Icons.check),
                      iconSize: 40.sp,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
