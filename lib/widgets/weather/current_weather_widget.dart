import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Center(
                child: Txt(getTemperature(weatherData.list.first.main.temp),
                    style: context.title
                        .copyWith(color: Colors.white, fontSize: 100.sp),
                    translate: false)),
            Txt("${weatherData.city.country}, ${weatherData.city.name}",
                bold: true, size: 20.sp, color: Colors.white, translate: false),
            Builder(builder: (context) {
              List<IconData> icons = [];
              if (context.dataWatch.mainCity != null) {
                icons.add(Icons.near_me);
              }
              icons.addAll(context.dataWatch.cityList.map((e) => Icons.circle));
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...List.generate(
                      icons.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              icons[index],
                              size: 10.sp,
                              color: index == context.dataWatch.currentCityIndex
                                  ? Colors.white
                                  : Colors.white30,
                            ),
                          ))
                ],
              );
            }),
            Txt(capitalize(weatherData.list.first.weather.first.description),
                translate: false, size: 12.sp, color: Colors.white),
            Builder(builder: (context) {
              final data = getDailyMaxMinTemperatures(weatherData.list);
              String maxTemp = getTemperature(data.first['max']);
              String minTemp = getTemperature(data.first['min']);
              return Txt('${txt('H')}:$maxTemp ${txt('L')}:$minTemp',
                  translate: false, color: Colors.white70, size: 14.sp);
            }),
          ],
        ),
      );
    });
  }
}
