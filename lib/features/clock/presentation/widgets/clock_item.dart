import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:g_lab/core/constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone_country/timezone_country.dart';

class ClockItem extends StatefulWidget {
  final tz.Location location;
  const ClockItem({super.key, required this.location});

  @override
  State<ClockItem> createState() => _ClockItemState();
}

class _ClockItemState extends State<ClockItem> {
  String? countryCode;
  DateTime? dateTime;
  String? diffrence;

  @override
  void initState() {
    countryCode = TimezoneConvert.timezoneToCountryCode(widget.location.name);
    tz.TZDateTime tzDateTime = tz.TZDateTime.now(widget.location);
    dateTime = DateTime(
      tzDateTime.year,
      tzDateTime.month,
      tzDateTime.day,
      tzDateTime.hour,
      tzDateTime.minute,
      tzDateTime.second,
    );
    if (widget.location.currentTimeZone.offset.inHours -
            tz.local.currentTimeZone.offset.inHours >
        0) {
      diffrence =
          '+${widget.location.currentTimeZone.offset.inHours - tz.local.currentTimeZone.offset.inHours}h Ahead';
    } else if (widget.location.currentTimeZone.offset.inHours -
            tz.local.currentTimeZone.offset.inHours <
        0) {
      diffrence =
          '-${widget.location.currentTimeZone.offset.inHours - tz.local.currentTimeZone.offset.inHours}h Behind';
    } else {
      diffrence = 'Same as local time';
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tz.TZDateTime tzDateTime = tz.TZDateTime.now(widget.location);
    dateTime = DateTime(
      tzDateTime.year,
      tzDateTime.month,
      tzDateTime.day,
      tzDateTime.hour,
      tzDateTime.minute,
      tzDateTime.second,
    );
    return Ink(
      decoration: BoxDecoration(
        color: AppColors.deepGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.location.name.split('/').last,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18.sp,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  // '${widget.location.currentTimeZone.offset.inHours.isNegative ? '' : '+'}${widget.location.currentTimeZone.offset.inHours}h',
                  diffrence ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18.sp,
                    color: AppColors.greyy,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat.jm().format(dateTime!).split(' ').first,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 36.sp,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 7.sp),
                  child: Text(
                    DateFormat.jm().format(dateTime!).split(' ').last,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
