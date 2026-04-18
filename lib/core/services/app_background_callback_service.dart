// import 'package:auto_start_flutter/auto_start_flutter.dart';
// import 'package:flutter/material.dart';

// class AppBackgroundCallbackService {
//   static Future<void> init() async {
//     // 2. Register it somewhere in your app (main.dart)
//     await registerBootCallback(myBootCallback);
//   }

//   static Future<void> startForgroundService() async {
//     // Start the service
//     await startForegroundService(
//       title: "Syncing Data",
//       content: "Do not close the app.",
//     );
//   }
// }

// // تنفيذ اجراء معين فور اعادة تشغيل الهاتف
// @pragma('vm:entry-point')
// void myBootCallback() {
//   WidgetsFlutterBinding.ensureInitialized();
//   print("Device booted! Running in the background...");
// }
