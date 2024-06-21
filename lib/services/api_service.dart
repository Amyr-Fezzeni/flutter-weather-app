// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';

class ApiService {
  static const apiUrl = "https://api.openweathermap.org";

  // static Future<CityWeather?> getCurrentWeatherDataByCordinate(
  //     {required double lat, required double lon, required String lang}) async {
  //   try {
  //     final http.Response request = await http.get(
  //         Uri.parse(
  //             "$apiUrl/data/2.5/weather?lat=$lat&lon=$lon&lang$lang&appid=${dotenv.get('API_KEY')}"),
  //         headers: {"content-type": "application/json"});
  //     final body = json.decode(request.body);
  //     if ([200, 201].contains(request.statusCode)) {
  //       return CityWeather.fromApi(body);
  //     }
  //   } catch (e) {
  //     log('error: $e');
  //   }
  //   return null;
  // }

  // static Future<CityWeather?> getCurrentWeatherDataByCity(
  //     {required String city, required String lang}) async {
  //   try {
  //     final http.Response request = await http.get(
  //         Uri.parse(
  //             "$apiUrl/data/2.5/weather?q=$city&lang$lang&appid=${dotenv.get('API_KEY')}"),
  //         headers: {"content-type": "application/json"});
  //     final body = json.decode(request.body);
  //     if ([200, 201].contains(request.statusCode)) {
  //       return CityWeather.fromApi(body);
  //     }
  //   } catch (e) {
  //     log('error: $e');
  //   }
  //   return null;
  // }

  static Future<WeatherModel?> getForecastWeatherDataByCordinate(
      {required double lat, required double lon, required String lang}) async {
    try {
      final http.Response request = await http.get(
          Uri.parse(
              "$apiUrl/data/2.5/forecast?lat=$lat&lon=$lon&lang$lang&appid=${dotenv.get('API_KEY')}"),
          headers: {"content-type": "application/json"});
      final body = json.decode(request.body);
      if ([200, 201].contains(request.statusCode)) {
        return WeatherModel.fromJson(body);
      }
    } catch (e) {
      log('error: $e');
    }
    return null;
  }

  static Future<WeatherModel?> getForecastWeatherDataByCity(
      {required String city, required String lang}) async {
    try {
      final http.Response request = await http.get(
          Uri.parse(
              "$apiUrl/data/2.5/forecast?q=$city&lang$lang&appid=${dotenv.get('API_KEY')}"),
          headers: {"content-type": "application/json"});
      final body = json.decode(request.body);
      if ([200, 201].contains(request.statusCode)) {
        return WeatherModel.fromJson(body);
      }
    } catch (e) {
      log('error: $e');
    }
    return null;
  }

  static Future<List<CityInfo>> getListCities({required String query}) async {
    List<CityInfo> cities = [];
    try {
      final http.Response request = await http.get(
          Uri.parse(
              "$apiUrl/geo/1.0/direct?q=$query&limit=10&appid=${dotenv.get('API_KEY')}"),
          headers: {"content-type": "application/json"});
      final body = json.decode(request.body);
      if ([200, 201].contains(request.statusCode)) {
        return List<CityInfo>.from(body.map((data) => CityInfo.fromJson(data)));
      }
    } catch (e) {
      log('error: $e');
    }
    return cities;
  }
}
