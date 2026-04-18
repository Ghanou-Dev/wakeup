import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/features/timer/presentation/helper/time_is.dart';

class PickDuration extends StatefulWidget {
  final TimeIs timeIs;
  final int maxLen;
  final Function(int value) onChanged;
  const PickDuration({
    super.key,
    required this.timeIs,
    required this.maxLen,
    required this.onChanged,
  });

  @override
  State<PickDuration> createState() => _PickDurationState();
}

class _PickDurationState extends State<PickDuration> {
  int selectedItem = 0;
  late FixedExtentScrollController fixedExtentScrollController;

  @override
  void initState() {
    fixedExtentScrollController = FixedExtentScrollController(
      initialItem: selectedItem,
    );
    super.initState();
  }

  @override
  void dispose() {
    fixedExtentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 120.h,
      child: ListWheelScrollView.useDelegate(
        // تثبيت العنصر في المنتصف
        controller: fixedExtentScrollController,
        physics: const FixedExtentScrollPhysics(),
        // تكبير العنصر الذي في الوسط
        useMagnifier: true,
        magnification: 1.4,
        //
        onSelectedItemChanged: (value) {
          setState(() {
            selectedItem = value;
            widget.onChanged(selectedItem);
          });
        },
        //! required +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        // ارتفاع العنصر
        itemExtent: 40.h,
        // for loop scrool
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List.generate(
            widget.maxLen,
            (index) {
              //////////////////////////////////////////////////////////////////
              bool isSelected = selectedItem == index;

              return Center(
                child: Text(
                  index.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.bold,
                    fontSize: 26.sp,
                    color: isSelected ? AppColors.yellow : AppColors.white,
                  ),
                ),
              );
            },
          ),
        ),
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      ),
    );
  }
}
