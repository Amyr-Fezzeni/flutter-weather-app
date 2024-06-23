

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather%20model/city.dart';
import 'package:weather_app/models/weather%20model/main_weather.dart';
import 'package:weather_app/models/weather%20model/weather_list.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:weather_app/services/util.dart';

List<Map<String, dynamic>> filterNext24Hour(List<WeatherList> weatherList) {
  List<Map<String, dynamic>> hourlyTemps = [];

  for (var weather in weatherList.take(24)) {
    String time = DateFormat('HH:mm').format(weather.dt);
    hourlyTemps.add({
      'time': time,
      'deg':weather.wind.deg,
      'temp': getTemperature(weather.main.temp),
      'wind': getWindSpeed(weather.wind.speed),
      'icon': weather.weather.first.icon
    });
  }

  return hourlyTemps;
}

List<Map<String, dynamic>> get5DaysData(List<WeatherList> weatherList) {
  Map<String, Map<String, dynamic>> hourlyTemps = {};

  for (var weather in weatherList.take(24)) {
    Map<String, dynamic> dateDetails = getDateDetails(weather.dt);
    String date = dateDetails['date'];
    if (!hourlyTemps.containsKey(date)) {
      hourlyTemps[date] = {
        'date': date,
        'dayName': dateDetails['dayName'],
        'max': weather.main.temp,
        'maxIcon': weather.weather.first.icon,
        'min': weather.main.temp,
        'minIcon': weather.weather.first.icon,
        'wind': [
          {'speed': weather.wind.speed, "deg": weather.wind.deg}
        ],
        'icons': weather.weather.map((e) => e.icon).toList(),
      };
    } else {
      if (weather.main.temp > hourlyTemps[date]!['max']!) {
        hourlyTemps[date]!['max'] = weather.main.temp;
        hourlyTemps[date]!['maxIcon'] = weather.weather.first.icon;
      }
      if (weather.main.temp < hourlyTemps[date]!['min']!) {
        hourlyTemps[date]!['min'] = weather.main.temp;
        hourlyTemps[date]!['minIcon'] = weather.weather.first.icon;
      }
      hourlyTemps[date]!['wind']
          .add({'speed': weather.wind.speed, "deg": weather.wind.deg});
      hourlyTemps[date]!['icons'].addAll(weather.weather.map((e) => e.icon));
    }
  }
  for (var key in hourlyTemps.keys) {
    List<Map<String, dynamic>> windList = hourlyTemps[key]!['wind'];
    hourlyTemps[key]!['wind'] = getAverageWindSpeed(windList);
  }
  return hourlyTemps.values.toList();
}

List<Map<String, dynamic>> getDailyMaxMinTemperatures(
    List<WeatherList> weatherList) {
  Map<String, Map<String, dynamic>> dailyTemps = {};

  for (var weather in weatherList) {
    String date = weather.dtTxt.split(' ')[0]; // Extract the date part

    if (!dailyTemps.containsKey(date)) {
      dailyTemps[date] = {
        'day': date,
        'max': weather.main.temp,
        'min': weather.main.temp,
        'icons': weather.weather.map((e) => e.icon).toList(),
      };
    } else {
      if (weather.main.temp > dailyTemps[date]!['max']!) {
        dailyTemps[date]!['max'] = weather.main.temp;
      }
      if (weather.main.temp < dailyTemps[date]!['min']!) {
        dailyTemps[date]!['min'] = weather.main.temp;
      }
      dailyTemps[date]!['icons'].addAll(weather.weather.map((e) => e.icon));
    }
  }

  return dailyTemps.values.toList();
}

Map<String, String> getSunsetSunriseTime(City city) {
  if (isDay(city)) {
    return {
      "title": "Sunset",
      "date": DateFormat('HH:mm')
          .format(getTimeZone(time: city.sunset, timezone: city.timezone))
    };
  }
  return {
    "title": "Sunrise",
    "date": DateFormat('HH:mm')
        .format(getTimeZone(time: city.sunrise, timezone: city.timezone))
  };
}

bool isDay(City city) {
  final currentTime = getTimeZoneCityDate(city.timezone);
  final sunset = getTimeZone(time: city.sunset, timezone: city.timezone);
  final sunrise = getTimeZone(time: city.sunrise, timezone: city.timezone);
  return currentTime.isAfter(sunrise) && currentTime.isBefore(sunset);
}

String getTimeZoneCityString(City city) {
  tz.initializeTimeZones();
  DateTime timeInCity =
      DateTime.now().toUtc().add(Duration(seconds: city.timezone));
  return DateFormat('HH:mm').format(timeInCity);
}

DateTime getTimeZoneCityDate(int timezone) {
  tz.initializeTimeZones();
  return DateTime.now().toUtc().add(Duration(seconds: timezone));
}

DateTime getTimeZone({required DateTime time, required int timezone}) {
  return time.add(Duration(seconds: timezone));
}

String getPressure(MainWeather main) {
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  const double hpaToInHg = 0.02953;
  const double hpaToAtm = 0.000986923;
  double pressure = main.pressure.toDouble();
  switch (context.dataWatch.atmospherePressureUnit.code) {
    case 'inHg':
      pressure *= hpaToInHg;
      break;
    case 'atm':
      pressure *= hpaToAtm;
      break;
  }
  return '${pressure.round()} ${context.dataWatch.atmospherePressureUnit.code}';
}

String getVisibility(WeatherList weather) {
  return '${weather.visibility ~/ 1000} Km';
}

String getTemperature(double? temp) {
  if (temp == null) return "";
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  double calculatedTemp = temp - 273.15;
  if (context.dataWatch.temperatureUnit.code == 'F') {
    calculatedTemp = calculatedTemp * (9 / 5) + 32;
  }
  return "${(calculatedTemp).toInt()}°"; //${context.dataWatch.temperatureUnit.name}
}

String getWindSpeed(double windSpeed) {
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  return '${(windSpeed * 3.6).round()} ${context.dataWatch.windSpeedUnit.code}';
}

String getHumidity(MainWeather main) {
  return '${main.humidity} %';
}

String getRealFeel(MainWeather main) {
  return getTemperature(main.feelsLike);
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
