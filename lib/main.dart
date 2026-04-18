import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_routes.dart';
import 'package:g_lab/core/dependencies_injection.dart' as di;
import 'package:g_lab/features/alarm/data/models/alarm_model_type_adapter.dart';
import 'package:g_lab/features/alarm/data/models/alarm_repited_type_adatper.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_cubit/alarm_cubit.dart';
import 'package:g_lab/features/alarm/presentation/cubits/alarm_permissions_cubit/alarm_permissions_cubit.dart';
import 'package:g_lab/features/alarm/presentation/pages/home_page.dart';
import 'package:g_lab/features/alarm/presentation/pages/first_permission_page.dart';
import 'package:g_lab/features/clock/data/models/location_model_type_adapter.dart';
import 'package:g_lab/features/clock/presentation/cubits/clock_cubit.dart';
import 'package:g_lab/features/timer/presentation/cubits/timer_cubit.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // register type adapters
  Hive.registerAdapter(AlarmModelTypeAdapter());
  Hive.registerAdapter(AlarmRepitedTypeAdatper());
  Hive.registerAdapter(LocationModelTypeAdapter());
  // initialize dependencies injection
  await di.init();
  // initialization alarm settings
  await Alarm.init();
  // check first lunch
  Box<bool> isFirstLunchBox = await Hive.openBox<bool>('isFirstLunch');
  bool isFirstLunch = isFirstLunchBox.get('isFirstLunch') ?? true;
  // init just audio
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.wakeup.gon',
    androidNotificationChannelName: 'wakeup',
    androidNotificationOngoing: true,
  );
  // init Timezone
  tz.initializeTimeZones();

  // run
  runApp(
    GLab(
      isFirstLunch: isFirstLunch,
    ),
  );
}

class GLab extends StatelessWidget {
  final bool isFirstLunch;
  const GLab({super.key, required this.isFirstLunch});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AlarmCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AlarmPermissionsCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<TimerCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ClockCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(386, 793),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                headlineMedium: TextStyle(color: AppColors.white),
              ),
              textSelectionTheme: const TextSelectionThemeData(
                selectionHandleColor: AppColors.yellow,
              ),
            ),
            routes: {
              AppRoutes.onBoarding: (context) =>
                  isFirstLunch ? const FirstPermissionPage() : const HomePage(),
              AppRoutes.home: (context) => const HomePage(),
            },
          );
        },
      ),
    );
  }
}
