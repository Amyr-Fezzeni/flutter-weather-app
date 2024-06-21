// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'city.dart';
import 'weather_list.dart';

class WeatherModel {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherList> list;
  final City city;

  WeatherModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: List<WeatherList>.from(json['list']
          .map((x) => WeatherList.fromJson(Map<String, dynamic>.from(x)))),
      city: City.fromJson(Map<String, dynamic>.from(json['city'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': List<dynamic>.from(list.map((x) => x.toJson())),
      'city': city.toJson(),
    };
  }

  @override
  String toString() {
    return 'WeatherModel(cod: $cod, message: $message, cnt: $cnt, city: $city, )'; //list: $list,
  }
}
