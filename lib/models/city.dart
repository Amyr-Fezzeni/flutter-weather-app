// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app/models/weather.dart';

class City {
  String name;
  String state;
  String country;
  double latitude;
  double longitude;
  List<Weather> weather;
  City({
    required this.name,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.weather,
  });
}
