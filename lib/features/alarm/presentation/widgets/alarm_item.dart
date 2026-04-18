import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/alarm_repited.dart';
import 'package:g_lab/features/alarm/domain/entitys/alarm_entity.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_cubit/alarm_cubit.dart';

class AlarmItem extends StatefulWidget {
  final String hint;
  final TimeOfDay time;
  final AlarmRepited repited;
  final bool isActive;
  final String id;
  const AlarmItem({
    super.key,
    required this.time,
    required this.repited,
    required this.hint,
    required this.isActive,
    required this.id,
  });

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 169.w,
      height: 177.h,
      decoration: BoxDecoration(
        color: AppColors.deepGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.hint,
              style: TextStyle(
                color: widget.isActive ? AppColors.white : AppColors.greyy,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    '${widget.time.hour.toString().padLeft(2, '0')}:${widget.time.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      color: widget.isActive
                          ? AppColors.white
                          : AppColors.greyy,
                      fontSize: 36.sp,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.time.period.name.toUpperCase(),
                    style: TextStyle(
                      color: widget.isActive
                          ? AppColors.white
                          : AppColors.greyy,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            widget.isActive
                ? StreamBuilder<TimeOfDay>(
                    stream: context
                        .read<AlarmCubit>()
                        .listenToAlarmDiffrenceTime(
                          alarm: AlarmEntity(
                            hint: widget.hint,
                            time: widget.time,
                            repited: widget.repited,
                            isActive: widget.isActive,
                            id: widget.id,
                          ),
                        ),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final time = snapshot.data;
                        return Text(
                          time?.hour == 0
                              ? 'Alarm in ${time!.minute.toString().padLeft(2, '0')} minute'
                              : 'Alarm in ${time!.hour.toString().padLeft(2, '0')} h : ${time.minute.toString().padLeft(2, '0')} m ',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14.sp,
                          ),
                        );
                      } else {
                        return Text(
                          widget.repited.name,
                          style: TextStyle(
                            color: widget.isActive
                                ? AppColors.white
                                : AppColors.greyy,
                            fontSize: 14.sp,
                          ),
                        );
                      }
                    },
                  )
                : Text(
                    widget.repited.name,
                    style: TextStyle(
                      color: AppColors.greyy,
                      fontSize: 14.sp,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: SizedBox(
                width: 40.8.w,
                height: 24.h,
                child: BlocBuilder<AlarmCubit, AlarmState>(
                  builder: (context, state) {
                    return Switch(
                      activeTrackColor: AppColors.yellow,
                      activeThumbColor: AppColors.deepGrey,
                      value: widget.isActive,
                      onChanged: (value) async {
                        // update alarm ^ // next
                        await context.read<AlarmCubit>().updateAlarm(
                          oldAlarm: AlarmEntity(
                            hint: widget.hint,
                            time: widget.time,
                            repited: widget.repited,
                            isActive: widget.isActive,
                            id: widget.id,
                          ),
                          newAlarm: AlarmEntity(
                            hint: widget.hint,
                            time: widget.time,
                            repited: widget.repited,
                            isActive: value,
                            id: widget.id,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
