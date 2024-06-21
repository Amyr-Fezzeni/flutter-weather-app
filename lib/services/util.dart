import 'package:flutter/material.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/services/navigation_service.dart';

String calculateTemperature(double? temp) {
  if (temp == null) return "";
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  double calculatedTemp = temp - 273.15;
  if (context.dataWatch.temperatureUnit.code == 'F') {
    calculatedTemp = calculatedTemp * (9 / 5) + 32;
  }
  return "${(calculatedTemp).toInt()}°";
}

List< Map<String, dynamic>> getDailyMaxMinTemperatures(
    WeatherModel weather) {
  Map<String, Map<String, dynamic>> dailyTemps = {};

  for (var weather in weather.list) {
    String date = weather.dtTxt.split(' ')[0]; // Extract the date part

    if (!dailyTemps.containsKey(date)) {
      dailyTemps[date] = {
        'day': date,
        'max': weather.main.tempMax,
        'min': weather.main.tempMin,
        'icons': weather.weather.map((e) => e.icon).toList(),
      };
    } else {

      if (weather.main.temp > dailyTemps[date]!['max']!) {
        dailyTemps[date]!['max'] = weather.main.tempMax;
      }
      if (weather.main.temp < dailyTemps[date]!['min']!) {
        dailyTemps[date]!['min'] = weather.main.tempMin;
      }
      dailyTemps[date]!['icons'].addAll(weather.weather.map((e) => e.icon));
    }
  }

  return dailyTemps.values.toList();
}

String getDayIcon(List<String> icons) {
  Map<String, int> frequencyMap = {};

  for (var str in icons) {
    if (frequencyMap.containsKey(str)) {
      frequencyMap[str] = frequencyMap[str]! + 1;
    } else {
      frequencyMap[str] = 1;
    }
  }

  String? mostRepetitiveIcon;
  int maxFrequency = 0;

  frequencyMap.forEach((str, frequency) {
    if (frequency > maxFrequency) {
      maxFrequency = frequency;
      mostRepetitiveIcon = str;
    }
  });

  return mostRepetitiveIcon ?? '';
}

String capitalize(String? text) {
  if (text == null || text.isEmpty) return '';
  return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
}

String weatherIcon(String description) {
  switch (description) {
    case 'clear sky':
      return "";
    case 'few clouds':
      return "";
    case 'scattered clouds':
      return "";
    case 'broken clouds':
      return "";
    case 'shower rain':
      return "";
    case 'rain':
      return "";
    case 'thunderstorm':
      return "";
    case 'snow':
      return "";
    case 'mist':
      return "";
    default:
      return '';
  }
}
