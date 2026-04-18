import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/core/widgets/custom_button.dart';
import 'package:g_lab/features/alarm/presentation/widgets/permission_guid.dart';

class CustomPermissionPage extends StatelessWidget {
  final String discreption;
  final String subDiscreption;
  final List<PermissionGuid> guids;
  final void Function() onPressed;
  const CustomPermissionPage({
    super.key,
    required this.discreption,
    required this.subDiscreption,
    required this.guids,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),
              Image.asset(
                'assets/images/alarm_clock.png',
                height: size.height / 6,
              ),
              SizedBox(height: 40.h),
              FittedBox(
                child: Text(
                  discreption,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.normal,
                    fontSize: 20.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                subDiscreption,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: AppColors.greyy,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: guids.length,
                  itemBuilder: (context, index) {
                    return guids[index];
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0.w,
                  vertical: 40.h,
                ),
                child: CustomButton(
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
