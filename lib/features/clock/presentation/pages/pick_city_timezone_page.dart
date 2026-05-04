import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:g_lab/core/constants/app_fonts.dart';
import 'package:g_lab/features/clock/presentation/cubits/clock_cubit.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone_country/timezone_country.dart';

class PickCityTimezonePage extends StatelessWidget {
  const PickCityTimezonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Select City',
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: AppColors.white,
                ),
              ),
            ),
            Text(
              'Time zones',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.normal,
                fontSize: 16.sp,
                color: AppColors.greyy,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          children: [
            BlocBuilder<ClockCubit, ClockState>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchAnchor.bar(
                  barHintText: 'Search Time zone',
                  barTrailing: [
                    IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
                  ],
                  suggestionsBuilder: (context, controller) {
                    final List<Location> filtredZones = state.allLocations
                        .where(
                          (element) => element.name
                              .split('/')
                              .last
                              .toLowerCase()
                              .contains(controller.text.toLowerCase()),
                        )
                        .toList();

                    return filtredZones.map(
                      (e) {
                        return ListTile(
                          onTap: () {
                            context.read<ClockCubit>().saveLocation(
                              location: e,
                            );
                            controller.closeView(e.name);
                            Navigator.of(context).pop();
                          },
                          title: Text(e.name.split('/').last),
                        );
                      },
                    );
                  },
                  onClose: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),

            Expanded(
              child: BlocBuilder<ClockCubit, ClockState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.allLocations.length,
                    itemBuilder: (context, index) {
                      //////////////////////////////////////////////////////////////////////////////////
                      String? countryCode =
                          TimezoneConvert.timezoneToCountryCode(
                            state.allLocations[index].name,
                          );
                      //////////////////////////////////////////////////////////////////////////////////
                      return ListTile(
                        onTap: () {
                          context.read<ClockCubit>().saveLocation(
                            location: state.allLocations[index],
                          );
                          Navigator.of(context).pop();
                        },
                        title: Text(
                          state.allLocations[index].name.split('/').last,
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: AppColors.white,
                          ),
                        ),
                        subtitle: Text(
                          '${TimezoneConvert.countryName(countryCode ?? 'US')} GMT ${state.allLocations[index].currentTimeZone.offset.inHours > 0 ? '+' : ''}${state.allLocations[index].currentTimeZone.offset.inHours} ',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontWeight: FontWeight.normal,
                            fontSize: 16.sp,
                            color: AppColors.greyy,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
