import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/services/weather_services.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherModel weatherData;
  const CurrentWeatherWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt(weatherData.city.name,
                bold: true, size: 18.sp, color: Colors.white),
            Txt(getTemperature(weatherData.list.first.main.temp),
                style: context.title.copyWith(
                    color: Colors.white.withOpacity(.9), fontSize: 120.sp)),
            Builder(builder: (context) {
              String description =
                  capitalize(weatherData.list.first.weather.first.description);
              final data = getDailyMaxMinTemperatures(weatherData.list);
              String maxTemp = getTemperature(data.first['max']);
              String minTemp = getTemperature(data.first['min']);
              return Txt('$description  $maxTemp / $minTemp',
                  translate: false, color: Colors.white);
            }),
            Row(
              children: [
                const Icon(Icons.access_time_rounded,
                    color: Colors.white70, size: 25),
                const Gap(10),
                Txt(getTimeZoneCity(weatherData.city),
                    translate: false, color: Colors.white),
              ],
            )
          ],
        ),
      );
    });
  }
}
