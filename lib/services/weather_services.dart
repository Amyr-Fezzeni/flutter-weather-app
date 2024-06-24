import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather%20model/city.dart';
import 'package:weather_app/models/weather%20model/main_weather.dart';
import 'package:weather_app/models/weather%20model/weather_list.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:weather_app/services/util.dart';

/// Filtrer les données météorologiques des 24 prochaines 3 heures à partir de la liste [weatherList].
///
/// Renvoie une liste de maps contenant les détails météorologiques par heure, y compris
/// l'heure, la direction du vent, la température, la vitesse du vent et l'icône météo.
List<Map<String, dynamic>> filterNext24Hour(List<WeatherList> weatherList) {
  List<Map<String, dynamic>> hourlyTemps = [];

  for (var weather in weatherList.take(24)) {
    String time = DateFormat('HH:mm').format(weather.dt);
    hourlyTemps.add({
      'time': time,
      'deg': weather.wind.deg,
      'temp': getTemperature(weather.main.temp),
      'wind': getWindSpeed(weather.wind.speed),
      'icon': weather.weather.first.icon
    });
  }

  return hourlyTemps;
}

/// Obtenir les données météorologiques des 5 prochains jours à partir de la liste [weatherList].
///
/// Renvoie une liste de maps contenant les détails météorologiques par jour, y compris
/// la date, le nom du jour, la température maximale et minimale, la vitesse moyenne du vent,
/// l'humidité, la pression atmosphérique et les icônes météo.
List<Map<String, dynamic>> get5DaysData(List<WeatherList> weatherList) {
  Map<String, Map<String, dynamic>> hourlyTemps = {};

  for (var weather in weatherList) {
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
        'humidity': [weather.main.humidity],
        'pressure': [weather.main.pressure],
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
      hourlyTemps[date]!['humidity'].add(weather.main.humidity);
      hourlyTemps[date]!['pressure'].add(weather.main.pressure);
      hourlyTemps[date]!['icons'].addAll(weather.weather.map((e) => e.icon));
    }
  }
  for (var key in hourlyTemps.keys) {
    List<Map<String, dynamic>> windList = hourlyTemps[key]!['wind'];
    hourlyTemps[key]!['wind'] = getAverageWindSpeed(windList);
    hourlyTemps[key]!['humidity'] =
        getAverageNumber(hourlyTemps[key]!['humidity']);
    hourlyTemps[key]!['pressure'] =
        getAverageNumber(hourlyTemps[key]!['pressure']).toDouble();
  }

  final todayData = weatherList
      .map((e) => getDateDetails(e.dt))
      .where((c) => c['date'] == hourlyTemps.values.first['date']);
  if (todayData.length < 2) return hourlyTemps.values.skip(1).toList();
  return hourlyTemps.values.toList();
}

/// Obtient les températures maximales et minimales quotidiennes à partir de la liste [weatherList].
///
/// Renvoie une liste de maps contenant les détails des températures maximales et minimales par jour,
/// ainsi que les icônes météo correspondantes.
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

/// Obtient l'heure du coucher ou du lever du soleil pour la ville donnée [city].
///
/// Utilise les données de lever et de coucher du soleil ajustées au fuseau horaire de la ville.
Map<String, String> getSunsetSunriseTime(City city) {
  final sunset = getTimeZone(time: city.sunset, timezone: city.timezone);
  final sunrise = getTimeZone(time: city.sunrise, timezone: city.timezone);

  if (isDay(city)) {
    return {"title": "Sunset", "date": DateFormat('HH:mm').format(sunset)};
  }
  return {"title": "Sunrise", "date": DateFormat('HH:mm').format(sunrise)};
}

/// Vérifie s'il fait jour pour la ville donnée [city] à l'heure actuelle.
///
/// Compare l'heure actuelle avec les heures de lever et de coucher du soleil ajustées au fuseau horaire de la ville.
bool isDay(City city) {
  final currentTime = getTimeZoneCityDate(city.timezone);
  final sunset = getTimeZone(time: city.sunset, timezone: city.timezone);
  final sunrise = getTimeZone(time: city.sunrise, timezone: city.timezone);
  return currentTime.isAfter(sunrise) && currentTime.isBefore(sunset);
}

/// Obtient l'heure actuelle ajustée au fuseau horaire de la ville [city].
String getTimeZoneCityString(City city) {
  DateTime timeInCity =
      DateTime.now().toUtc().add(Duration(seconds: city.timezone));
  return DateFormat('HH:mm').format(timeInCity);
}

/// Obtient la date actuelle ajustée au fuseau horaire de la ville [timezone].
DateTime getTimeZoneCityDate(int timezone) {
  return DateTime.now().toUtc().add(Duration(seconds: timezone));
}

/// Obtient l'heure ajustée au fuseau horaire donné [timezone].
DateTime getTimeZone({required DateTime time, required int timezone}) {
  return time.add(Duration(seconds: timezone));
}

/// Convertit la pression atmosphérique en unité spécifiée dans le contexte actuel.
///
/// Utilise l'unité de pression atmosphérique actuellement sélectionnée dans l'application
/// pour convertir la pression donnée en hectopascals (hPa) en pouces de mercure (inHg)
/// ou en atmosphères (atm) avant de renvoyer la valeur formatée.
String getPressure(double pressure) {
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  const double hpaToInHg = 0.02953;
  const double hpaToAtm = 0.000986923;
  // double pressure = pressure.toDouble();
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

/// Obtient la visibilité en kilomètres à partir des données météorologiques [weather].
String getVisibility(WeatherList weather) {
  return '${weather.visibility ~/ 1000} Km';
}

/// Convertit la température en unité spécifiée dans le contexte actuel.
///
/// Utilise l'unité de température actuellement sélectionnée dans l'application
/// pour convertir la température donnée de kelvin (K) en degrés Celsius (°C) ou Fahrenheit (°F)
/// avant de renvoyer la valeur formatée.
String getTemperature(double? temp) {
  if (temp == null) return "";
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  double calculatedTemp = temp - 273.15;
  if (context.dataWatch.temperatureUnit.code == 'F') {
    calculatedTemp = calculatedTemp * (9 / 5) + 32;
  }
  return "${(calculatedTemp).toInt()}°"; //${context.dataWatch.temperatureUnit.name}
}

/// Obtient la vitesse du vent en kilomètres par heure (km/h) à partir de la vitesse du vent donnée.
///
/// Utilise l'unité de vitesse du vent actuellement sélectionnée dans l'application pour
/// convertir la vitesse du vent de mètres par seconde (m/s) en kilomètres par heure (km/h)
/// avant de renvoyer la valeur formatée.
String getWindSpeed(double windSpeed) {
  BuildContext context = NavigationService.navigatorKey.currentContext!;
  return '${(windSpeed * 3.6).round()} ${context.dataWatch.windSpeedUnit.code}';
}

/// Obtient l'humidité en pourcentage (%) à partir des données météorologiques principales [main].
String getHumidity(MainWeather main) {
  return '${main.humidity} %';
}

/// Obtient la sensation thermique à partir des données météorologiques principales [main].
///
/// Renvoie la température ressentie en utilisant la fonction `getTemperature`.
String getRealFeel(MainWeather main) {
  return getTemperature(main.feelsLike);
}

/// Obtient l'icône météo dominante à partir de la liste des icônes météo [icons].
///
/// Détermine l'icône météo la plus fréquemment présente dans la liste et la renvoie.
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
