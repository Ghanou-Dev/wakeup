import 'dart:developer';

import 'package:auto_start_flutter/auto_start_flutter.dart';
import 'package:flutter/services.dart';
import 'package:g_lab/core/errors/exceptions.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  // check pirmissions /////////////////////////////////////////////////////////
  static Future<void> checkAndroidNotificationPermission() async {
    final status = await Permission.notification.status;
    if (status.isDenied) {
      await Permission.notification.request();
      print('request permission : check android notification permisiion');
    }
  }

  static Future<void> checkAndroidScheduleExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.status;
    print('Schedule exact alarm permission: $status.');
    if (status.isDenied) {
      print('Requesting schedule exact alarm permission...');
      final res = await Permission.scheduleExactAlarm.request();
      print(
        'Schedule exact alarm permission ${res.isGranted ? '' : 'not'} granted.',
      );
    }
  }

  // الحصول على معلوماتت حول الجهاز  /////////////////////////////////////////
  static Future<String?> getDeviceName() async {
    try {
      String? manufacturer = await getDeviceManufacturer();
      // e.g. "Xiaomi", "Apple", "Samsung"
      return manufacturer;
    } on Exception catch (e) {
      throw GetDeviceNameException(message: e.toString());
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  // open Other permission screen in miui [ Method Channel ] ///////////////////
  static final MethodChannel channel = const MethodChannel('overlay_permission');
  static Future<void> checkMiuiShowOnLockScreen() async {
    try {
      log('open wake lock screen ');
      await channel.invokeMethod('openOverlaySettings');
    } catch (e) {
      log('open app info screen ');
      await openAppInfo();
    }
  }

  // التحقق من اذن السماح بالتشغيل التلقائي /////////////////////////////////
  static Future<void> checkAutoStart() async {
    // 1. Check if auto-start permission is available / relevant
    // Android: Returns true for Xiaomi, Oppo, Vivo, etc.
    // iOS: Returns true if Background App Refresh is available (not restricted).
    try {
      var isAvailable = await isAutoStartAvailable;

      if (isAvailable == true) {
        // 2. Request permission / Open Settings
        // Android: Opens Auto Start settings or App Info.
        // iOS: Opens App Settings.
        // Windows/macOS: Opens Startup Apps / Login Items settings.
        await getAutoStartPermission();
      }
    } on Exception catch (e) {
      throw AutoStartException(message: e.toString());
    }
  }

  // ignoring battery optimizations ////////////////////////////////////////////
  static Future<void> ignoringBatteryOptimazation() async {
    bool isExempt = await isBatteryOptimizationDisabled ?? false;
    log("Battery Optimization Disabled: $isExempt");
    if (!isExempt) {
      try {
        await disableBatteryOptimization();
        isExempt = await isBatteryOptimizationDisabled ?? false;
        log('Battery Optimization Disabled: ttttrue / result: $isExempt');
      } on Exception catch (e) {
        throw IgnoreBatteryException(message: e.toString());
      }
    }
  }

  // go to app settings screen /////////////////////////////////////////////////
  static Future<void> openAppInfoScreen() async {
    // Android: Opens App Info
    // iOS: Opens App Settings
    try {
      await openAppInfo();
    } catch (e) {
      throw OpenAppInfoException(message: e.toString());
    }
  }
}
