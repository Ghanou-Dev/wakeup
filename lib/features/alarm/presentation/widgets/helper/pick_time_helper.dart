import 'package:flutter/material.dart';
import 'package:g_lab/features/alarm/presentation/widgets/custom_time_picker_body.dart';

Future<TimeOfDay?> pickTimeHepler({
  required BuildContext context,
  required TimeOfDay initTime,
}) async {
  return await showTimePicker(
    context: context,
    initialTime: initTime,
    builder: (context, child) {
      return CustomTimePickerBody(
        child: child,
      );
    },
  );
}
