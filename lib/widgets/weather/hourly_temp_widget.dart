import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/models/weather%20model/weather_list.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/blury_card.dart';

class HourlyTemperatureWidget extends StatelessWidget {
  final List<WeatherList> weatherList;
  const HourlyTemperatureWidget({super.key, required this.weatherList});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final data = filterNext24Hour(weatherList);
      return BluryCard(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt("24-hour forecast",
                color: Colors.white60, bold: true, size: 14.sp),
            const Gap(10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  ...data.map((e) => hourWeatherWidget(e)),
                ],
              ),
            ),
            const Gap(10),
          ],
        ),
      ));
    });
  }

  Widget hourWeatherWidget(Map<String, dynamic> data) {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            border: Border(
          right: BorderSide(
            color: Colors.white38,
            width: .5,
          ),
        )),
        child: Column(
          children: [
            Txt(data['temp'],
                bold: true, color: Colors.white, translate: false, size: 18.sp),
            const Gap(10),
            Image.asset(getAssetIcon(data['icon']),
                height: 30.sp, width: 30.sp),
            const Gap(15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: data['deg'] * pi / 180,
                  child: const Icon(Icons.arrow_upward_rounded,
                      size: 10, color: Colors.white),
                ),
                const Gap(2),
                Txt(data['wind'],
                    color: Colors.white, translate: false, size: 12.sp),
              ],
            ),
            const Gap(5),
            Txt(data['time'],
                color: Colors.white, translate: false, size: 14.sp),
          ],
        ),
      );
    });
  }
}
