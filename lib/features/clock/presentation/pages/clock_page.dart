import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/features/clock/presentation/cubits/clock_cubit.dart';
import 'package:g_lab/features/clock/presentation/pages/pick_city_timezone_page.dart';
import 'package:g_lab/features/clock/presentation/widgets/clock_item.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    TimeOfDay timeOfDay = TimeOfDay(
      hour: time.hour,
      minute: time.minute,
    );
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.black,
        title: const Text(
          'Clock',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 0,
        backgroundColor: AppColors.yellow,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PickCityTimezonePage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: AppColors.deepGrey,
        ),
      ),
      body: Builder(
        builder: (context) {
          return BlocBuilder<ClockCubit, ClockState>(
            builder: (context, state) {
              Set<tz.Location> savedLocations = state.savedLocations;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${timeOfDay.hourOfPeriod.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50.sp,
                              color: AppColors.white,
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Text(
                              timeOfDay.period.name.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 28.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Text(
                          DateFormat.MMMEd().format(DateTime.now()),
                          style: TextStyle(
                            color: AppColors.greyy,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: savedLocations.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onLongPress: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  buttonsBorderRadius: BorderRadius.circular(
                                    20,
                                  ),
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
                                  desc:
                                      'Are You Sure You Want To Delete This Zone',
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
                                      ///////////////////////////////////////////////////////////
                                      context.read<ClockCubit>().deleteLocation(
                                        location: savedLocations
                                            .toList()[index],
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
                              child: ClockItem(
                                location: savedLocations.toList()[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
