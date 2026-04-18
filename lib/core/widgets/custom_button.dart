import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  const CustomButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          MediaQuery.of(context).size.width,
          50.h,
        ),
        foregroundColor: AppColors.black,
        backgroundColor: AppColors.yellow,
      ),
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          'Open Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
