import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/util.dart';

class CityCard extends StatelessWidget {
  final WeatherModel city;
  const CityCard({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onLongPress: () => context.dataRead.removeCity(city),
        onTap: () => log(city.toString()),
        child: Container(
          // height: 100,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: context.bgcolor,
            borderRadius: defaultSmallRadius,
            boxShadow: defaultBoxShadow,
            gradient: getGradient(city.list.first.weather.first.main),
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(capitalize(city.city.name),
                      bold: true,
                      translate: false,
                      color: Colors.white,
                      size: 18),
                  Txt('${capitalize(city.list.first.weather.first.description)}  ${calculateTemperature(city.list.first.main.tempMax)} / ${calculateTemperature(city.list.first.main.tempMin)}',
                      translate: false, color: Colors.white),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Image.network(
                      "https://openweathermap.org/img/wn/${city.list.first.weather.first.icon}@2x.png",
                      height: 40,
                      width: 40),
                  Txt(calculateTemperature(city.list.first.main.temp),
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
