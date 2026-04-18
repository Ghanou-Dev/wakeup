import 'package:flutter/material.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/features/alarm/presentation/widgets/custom_bottom_sheet_body.dart';

void showBottomSheetHepler(BuildContext context) async {
  return showModalBottomSheet(
    backgroundColor: AppColors.deepGrey,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const CustomBottomSheetBody();
    },
  );
}
