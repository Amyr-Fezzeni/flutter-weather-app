import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/city.dart';

class ApiService {
  static const apiUrl = "https://api.openweathermap.org";

  // static String urlParam(
  //         {required double lat, required double lon, required String lang}) =>
  //     "$apiUrl?lat=$lat&lon=$lon&lan=$lang&appid=${dotenv.get('API_KEY')}";

  static Future<Map<String, dynamic>> getWeatherData(
      {required double lat, required double lon, required String lang}) async {
    try {
      log(dotenv.get('API_KEY'));
      final http.Response request = await http.get(
          Uri.parse(
              "$apiUrl/data/2.5/weather?lat=$lat&lon=$lon&lang=$lang&appid=${dotenv.get('API_KEY')}"),
          headers: {"content-type": "application/json"});
      final body = json.decode(request.body);
      log(body.toString());
      if ([200, 201].contains(request.statusCode)) {
      } else {}
    } catch (e) {
      log('error url: $e');
    }
    return {};
  }

  static Future<List<City>> getListCities({required String query}) async {
    List<City> cities = [];
    try {
      final http.Response request = await http.get(
          Uri.parse(
              "$apiUrl/geo/1.0/direct?q=$query&limit=10&appid=${dotenv.get('API_KEY')}"),
          headers: {"content-type": "application/json"});
      final body = json.decode(request.body);
      log(body.toString());
      if ([200, 201].contains(request.statusCode)) {
        for (var data in body) {
          cities.add(City(
              name: data['name'] ?? '',
              state: data['state'] ?? '',
              country: data['country'] ?? '',
              latitude: data['lat'],
              longitude: data['lon'],
              weather: []));
        }
      }
    } catch (e) {
      log('error url: $e');
    }
    return cities;
  }
}
