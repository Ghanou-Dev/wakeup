import 'package:flutter/material.dart';
import 'package:g_lab/core/constants/app_colors.dart';

class PermissionHint extends StatelessWidget {
  const PermissionHint({
    super.key,
    required this.notificationDiscreption,
  });

  final String notificationDiscreption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(color: AppColors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: FittedBox(
          child: Text(
            notificationDiscreption,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: Switch(
          activeTrackColor: const Color.fromARGB(
            255,
            7,
            245,
            130,
          ),
          value: true,
          onChanged: (v) {},
        ),
      ),
    );
  }
}
