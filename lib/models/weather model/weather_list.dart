// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'clouds.dart';
import 'main_weather.dart';
import 'sys.dart';
import 'weather.dart';
import 'wind.dart';

class WeatherList {
  final DateTime dt;
  final MainWeather main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Sys sys;
  final String dtTxt;

  WeatherList({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory WeatherList.fromJson(Map<String, dynamic> json) {
    return WeatherList(
      dt: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      main: MainWeather.fromJson(Map<String, dynamic>.from(json['main'])),
      weather: List<Weather>.from(json['weather']
          .map((x) => Weather.fromJson(Map<String, dynamic>.from(x)))),
      clouds: Clouds.fromJson(Map<String, dynamic>.from(json['clouds'])),
      wind: Wind.fromJson(Map<String, dynamic>.from(json['wind'])),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      sys: Sys.fromJson(Map<String, dynamic>.from(json['sys'])),
      dtTxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt.millisecondsSinceEpoch ~/ 1000,
      'main': main.toJson(),
      'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'visibility': visibility,
      'pop': pop,
      'sys': sys.toJson(),
      'dt_txt': dtTxt,
    };
  }

  @override
  String toString() {
    return 'WeatherList(dt: $dt, main: $main, weather: $weather, clouds: $clouds, wind: $wind, visibility: $visibility, pop: $pop, sys: $sys, dtTxt: $dtTxt)';
  }
}
