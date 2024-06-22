import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/services/weather_services.dart';

class CityCard extends StatefulWidget {
  final WeatherModel weatherData;
  final bool canBeDeleted;
  const CityCard(
      {super.key, required this.weatherData, this.canBeDeleted = true});

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  late final List<Map<String, dynamic>> _data;
  @override
  void initState() {
    _data = getDailyMaxMinTemperatures(widget.weatherData.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onLongPress: () {
          if (!widget.canBeDeleted) return;
          context.dataRead.removeCity(widget.weatherData);
        },
        onTap: () => log(widget.weatherData.toString()),
        child: Container(
          height: 100.sp,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              color: context.bgcolor,
              borderRadius: defaultSmallRadius,
              boxShadow: defaultBoxShadow,
              image: DecorationImage(
                  image: AssetImage(weatherBackgroungCard(
                      widget.weatherData.list.first.weather.first.main,
                      isDay(widget.weatherData.city))),
                  fit: BoxFit.cover)),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(capitalize(widget.weatherData.city.name),
                      bold: true,
                      translate: false,
                      color: Colors.white,
                      size: 18),
                  Builder(builder: (context) {
                    String description = capitalize(widget
                        .weatherData.list.first.weather.first.description);
                    String maxTemp = getTemperature(_data.first['max']);
                    String minTemp = getTemperature(_data.first['min']);
                    return Txt('$description  $maxTemp / $minTemp',
                        translate: false, color: Colors.white);
                  }),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Image.network(
                      getIconUrl(
                          widget.weatherData.list.first.weather.first.icon),
                      height: 40,
                      width: 40),
                  Txt(getTemperature(widget.weatherData.list.first.main.temp),
                      color: Colors.white, bold: true, size: 20),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
