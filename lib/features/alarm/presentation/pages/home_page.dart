import 'dart:async';
import 'package:alarm/utils/alarm_set.dart';
import 'package:flutter/material.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/services/app_alarm_service.dart';
import 'package:g_lab/features/alarm/presentation/pages/alarm_page.dart';
import 'package:g_lab/features/alarm/presentation/pages/display_alarm_screen.dart';
import 'package:g_lab/features/clock/presentation/pages/clock_page.dart';
import 'package:g_lab/features/stopwatch/presentation/pages/stopwatch_page.dart';
import 'package:g_lab/features/timer/presentation/pages/timer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription<AlarmSet>? streamSubscription;

  @override
  void initState() {
    super.initState();
    // listen to alarm ringing /////////////////////////////////////////////////
    streamSubscription = AppAlarmService.listenToAlarmStart(
      onAlarmStart: (alarmSettings) async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DisplayAlarmScreen(
              alarm: alarmSettings,
            ),
          ),
        );
      },
    );
  }

  List<Widget> pages = [
    const AlarmPage(),
    const ClockPage(),
    const TimerPage(),
    const StopwatchPage(),
  ];
  int index = 0;

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        backgroundColor: AppColors.deepGrey,
        selectedItemColor: AppColors.yellow,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Alarm',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.watch_later_outlined),
            label: 'Clock',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_bottom),
            label: 'Timer',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: 'StopWatch',
          ),
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      body: pages[index],
    );
  }
}
