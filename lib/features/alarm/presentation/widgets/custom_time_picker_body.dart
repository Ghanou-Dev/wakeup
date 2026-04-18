import 'package:flutter/material.dart';
import 'package:g_lab/core/constants/app_colors.dart';

class CustomTimePickerBody extends StatelessWidget {
  final Widget? child;
  const CustomTimePickerBody({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: AppColors.black,
          //
          dialBackgroundColor: AppColors.deepGrey,
          dialHandColor: AppColors.yellow,
          dialTextColor: WidgetStateColor.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.black;
              } else {
                return AppColors.white;
              }
            },
          ),
          dialTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          //
          dayPeriodColor: WidgetStateColor.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.yellow;
              } else {
                return AppColors.deepGrey;
              }
            },
          ),
          dayPeriodTextColor: WidgetStateColor.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.black;
              } else {
                return AppColors.white;
              }
            },
          ),
          //
          hourMinuteColor: WidgetStateColor.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.yellow;
              } else {
                return AppColors.deepGrey;
              }
            },
          ),
          hourMinuteTextColor: WidgetStateColor.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.black;
              } else {
                return AppColors.white;
              }
            },
          ),
          //
          timeSelectorSeparatorColor: const WidgetStatePropertyAll(
            AppColors.white,
          ),
          //
          entryModeIconColor: AppColors.yellow,
          helpTextStyle: const TextStyle(color: AppColors.yellow),
          //
          cancelButtonStyle: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.yellow),
          ),
          //
          confirmButtonStyle: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(AppColors.yellow),
          ),
        ),
      ),
      child: child!,
    );
  }
}
