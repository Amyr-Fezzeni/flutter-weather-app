import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/models/weather%20model/weather_list.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/views/weather/forecast_days.dart';
import 'package:weather_app/widgets/blury_card.dart';
import 'package:weather_app/widgets/extra_widgets.dart';

class DaysForecastWidget extends StatelessWidget {
  final List<WeatherList> weatherList;
  const DaysForecastWidget({super.key, required this.weatherList});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final data = get5DaysData(weatherList);
      return BluryCard(
          child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt("Forecast", color: Colors.white60, bold: true, size: 14.sp),
            ...data.take(3).map((e) => dayWeatherWidget(e)),
            const Gap(10),
            BluryCard(
                child: InkWell(
              onTap: () =>
                  context.moveTo(Forecast4DaysScreen(forecastData: data)),
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Txt("5-day forecast",
                      bold: true, color: Colors.white, size: 14.sp),
                ),
              ),
            ))
          ],
        ),
      ));
    });
  }

  Widget dayWeatherWidget(Map<String, dynamic> data) {
    return Column(
      children: [
        Row(
          children: [
            ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 100),
                child: Txt(data['dayName'], color: Colors.white, size: 14.sp)),
            const Spacer(),
            Image.asset(getAssetIcon(getDayIcon(data['icons'])),
                height: 35.sp, width: 30.sp),
            const Spacer(
              flex: 2,
            ),
            Txt("${getTemperature(data['max'])} / ${getTemperature(data['min'])}",
                color: Colors.white, translate: false, size: 14.sp),
          ],
        ),
        divider(bottom: 5)
      ],
    );
  }
}
