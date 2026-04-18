import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';

class PermissionGuid extends StatelessWidget {
  final int number;
  final String text1;
  final String text2;
  const PermissionGuid({
    super.key,
    required this.number,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.yellow,
        radius: 16.r,
        child: Text(
          '$number',
          style: const TextStyle(color: AppColors.black),
        ),
      ),
      title: Row(
        children: [
          FittedBox(
            child: Text(
              '$text1 ',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: AppColors.white,
              ),
            ),
          ),
          FittedBox(
            child: Text(
              text2,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
