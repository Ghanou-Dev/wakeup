import 'package:flutter/material.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';

class LapItem extends StatelessWidget {
  final int index;
  final String time;
  const LapItem({
    super.key,
    required this.index,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.flag,
        color: AppColors.yellow,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FittedBox(
            child: Text(
              index.toString().padLeft(2, '0'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.yellow,
              ),
            ),
          ),
          FittedBox(
            child: Text(
              time,
              style: const TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
