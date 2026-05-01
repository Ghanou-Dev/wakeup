import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_routes.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_cubit/alarm_cubit.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_permissions_cubit/alarm_permissions_cubit.dart';
import 'package:g_lab/features/alarm/presentation/pages/custom_permission_page.dart';
import 'package:g_lab/features/alarm/presentation/widgets/permission_guid.dart';

class FirstPermissionPage extends StatelessWidget {
  const FirstPermissionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // custom status bar color
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: AppColors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    // fix orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomPermissionPage(
                  discreption: 'Allow Auto Start Permission',
                  subDiscreption:
                      'Don\'t Let Your Alarms Silent ,Auto Start will wake it up so that you never miss any alarm',
                  guids: <PermissionGuid>[
                    const PermissionGuid(
                      number: 1,
                      text1: 'Open',
                      text2: 'Settinges',
                    ),
                    const PermissionGuid(
                      number: 2,
                      text1: 'Swip to',
                      text2: 'Find Wake Up',
                    ),
                    const PermissionGuid(
                      number: 3,
                      text1: 'Tap the',
                      text2: 'Switch To Turn On',
                    ),
                  ],
                  onPressed: () async {
                    await context
                        .read<AlarmPermissionsCubit>()
                        .openAutoStartPermissionScreen();
                    //////////////////////////////////////////////////////////////
                    //! get device name
                    final String deviceName = await context
                        .read<AlarmPermissionsCubit>()
                        .getDeviceName();

                    /// Check device name ////////////////////////////////////////////////////////////////////////
                    if (deviceName.toLowerCase() == 'xiaomi') {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => CustomPermissionPage(
                            discreption: 'Allow Show on Lock screen',
                            subDiscreption:
                                'Turn on this permission to Dismiss Alarm Without Unlocking',
                            guids: [
                              const PermissionGuid(
                                number: 1,
                                text1: 'Tap',
                                text2: 'Other Permissions',
                              ),
                              const PermissionGuid(
                                number: 2,
                                text1: 'Tap',
                                text2: 'Show on Lock screen',
                              ),
                              const PermissionGuid(
                                number: 3,
                                text1: 'Tap',
                                text2: 'Allow to confirm and that\'s it!',
                              ),
                            ],
                            onPressed: () async {
                              await context
                                  .read<AlarmPermissionsCubit>()
                                  .openAppInfoScreen();

                              /// device settings ////////////////////////////////////////////////////
                              // await context
                              //     .read<AlarmPermissionsCubit>()
                              //     .openDeviceSettings();
                              ////////////////////////////////////////////////////////////////////////
                              Navigator.of(
                                context,
                              ).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => CustomPermissionPage(
                                    discreption:
                                        'Allow Run in Background Permission ',
                                    subDiscreption:
                                        'Don\'t Let Your Alarms Silent Let App Always run in background',
                                    guids: <PermissionGuid>[
                                      const PermissionGuid(
                                        number: 1,
                                        text1: 'Open',
                                        text2: 'Settings',
                                      ),
                                      const PermissionGuid(
                                        number: 2,
                                        text1: 'and',
                                        text2: 'Allow Permission',
                                      ),
                                    ],
                                    onPressed: () async {
                                      await context
                                          .read<AlarmPermissionsCubit>()
                                          .openDisibleBatteryOptimizationScreen();
                                      //////////////////////////////////////////////
                                      await context
                                          .read<AlarmCubit>()
                                          .completedFirstLunch();

                                      Navigator.of(
                                        context,
                                      ).pushReplacementNamed(AppRoutes.home);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                      //////////////////////////////////////////////////////////////////////////////////
                    } else if (deviceName.toLowerCase() == 'realme' ||
                        deviceName.toLowerCase() == 'oppo') {
                      Navigator.of(
                        context,
                      ).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => CustomPermissionPage(
                            discreption: 'Allow Run in Background Permission ',
                            subDiscreption:
                                'Don\'t Let Your Alarms Silent Let App Always run in background',
                            guids: <PermissionGuid>[
                              const PermissionGuid(
                                number: 1,
                                text1: 'Tap',
                                text2: 'Battery usage',
                              ),
                              const PermissionGuid(
                                number: 2,
                                text1: 'and Tap',
                                text2: 'Allow Background Activity',
                              ),
                            ],
                            onPressed: () async {
                              await context
                                  .read<AlarmPermissionsCubit>()
                                  .openAppInfoScreen();
                              ////////////////////////////////////////////////////////////////////////////
                              Navigator.of(
                                context,
                              ).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => CustomPermissionPage(
                                    discreption: 'Allow Notifications ',
                                    subDiscreption:
                                        'Allow this permission so that alarms and reminders work properly, even in the background',
                                    guids: <PermissionGuid>[
                                      const PermissionGuid(
                                        number: 1,
                                        text1: 'Tap',
                                        text2: 'Allow Permission Button',
                                      ),
                                      const PermissionGuid(
                                        number: 2,
                                        text1: 'and',
                                        text2: 'Allow Permission',
                                      ),
                                    ],
                                    onPressed: () async {
                                      await context
                                          .read<AlarmPermissionsCubit>()
                                          .allowNotification();
                                      //////////////////////////////////////////////
                                      Navigator.of(
                                        context,
                                      ).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => CustomPermissionPage(
                                            discreption:
                                                'Allow Run in Background Permission ',
                                            subDiscreption:
                                                'Don\'t Let Your Alarms Silent Let App Always run in background',
                                            guids: <PermissionGuid>[
                                              const PermissionGuid(
                                                number: 1,
                                                text1: 'Tap',
                                                text2:
                                                    'Allow Permission Button',
                                              ),
                                              const PermissionGuid(
                                                number: 2,
                                                text1: 'and',
                                                text2: 'Allow Permission',
                                              ),
                                            ],
                                            onPressed: () async {
                                              await context
                                                  .read<AlarmPermissionsCubit>()
                                                  .openDisibleBatteryOptimizationScreen();
                                              //////////////////////////////////////////////
                                              await context
                                                  .read<AlarmCubit>()
                                                  .completedFirstLunch();

                                              Navigator.of(
                                                context,
                                              ).pushReplacementNamed(
                                                AppRoutes.home,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                      //////////////////////////////////////////////////////////////////////////////////
                    } else {
                      Navigator.of(
                        context,
                      ).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => CustomPermissionPage(
                            discreption: 'Allow Run in Background Permission ',
                            subDiscreption:
                                'Don\'t Let Your Alarms Silent Let App Always run in background',
                            guids: <PermissionGuid>[
                              const PermissionGuid(
                                number: 1,
                                text1: 'Tap',
                                text2: 'Allow Permission Button',
                              ),
                              const PermissionGuid(
                                number: 2,
                                text1: 'and',
                                text2: 'Allow Permission',
                              ),
                            ],
                            onPressed: () async {
                              await context
                                  .read<AlarmPermissionsCubit>()
                                  .openDisibleBatteryOptimizationScreen();
                              //////////////////////////////////////////////
                              await context
                                  .read<AlarmCubit>()
                                  .completedFirstLunch();

                              Navigator.of(
                                context,
                              ).pushReplacementNamed(AppRoutes.home);
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
