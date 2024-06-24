// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/city_info.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
/// A class for making API calls to retrieve weather and city information.
///
/// Uses http package for network requests and json package for data parsing.
/// Utilizes OpenWeatherMap API for weather and city data.
///
/// Dependencies:
/// - flutter_dotenv: ^5.0.2
/// - http: ^0.13.3
/// - weather_app/models/city.dart
/// - weather_app/models/weather_model/weather_model.dart
///
/// Example usage:
/// ```dart
/// WeatherModel? weather = await ApiService.getForecastWeatherDataByCity(city: 'London', lang: 'en');
/// List<CityInfo> cities = await ApiService.getListCities(query: 'New York');
/// ```
///
/// Note: Ensure to provide the correct API_KEY using dotenv.
class ApiService {
  static const apiUrl = "https://api.openweathermap.org";

  /// Retrieves forecast weather data by geographical coordinates.
  static Future<WeatherModel?> getForecastWeatherDataByCordinate({
    required double lat,
    required double lon,
    required String lang,
  }) async {
    try {
      final http.Response request = await http.get(
        Uri.parse(
            "$apiUrl/data/2.5/forecast?lat=$lat&lon=$lon&lang=$lang&appid=${dotenv.get('API_KEY')}"),
        headers: {"content-type": "application/json"},
      );
      final body = json.decode(request.body);
      if ([200, 201].contains(request.statusCode)) {
        return WeatherModel.fromJson(body);
      }
    } catch (e) {
      // log('error: $e');
    }
    return null;
  }

  /// Retrieves forecast weather data by city name.
  static Future<WeatherModel?> getForecastWeatherDataByCity({
    required String city,
    required String lang,
    String? key
  }) async {
    try {
      final http.Response request = await http.get(
        Uri.parse(
            "$apiUrl/data/2.5/forecast?q=$city&lang=$lang&appid=${key??dotenv.get('API_KEY')}"),
        headers: {"content-type": "application/json"},
      );
      final body = json.decode(request.body);
      if ([200, 201].contains(request.statusCode)) {
        return WeatherModel.fromJson(body);
      }
    } catch (e) {
      // log('error: $e');
    }
    return null;
  }

  /// Retrieves a list of cities matching the given query.
  static Future<List<CityInfo>> getListCities({required String query}) async {
    List<CityInfo> cities = [];
    try {
      final http.Response request = await http.get(
        Uri.parse(
            "$apiUrl/geo/1.0/direct?q=$query&limit=10&appid=${dotenv.get('API_KEY')}"),
        headers: {"content-type": "application/json"},
      );
      final body = json.decode(request.body);
      if ([200, 201].contains(request.statusCode)) {
        return List<CityInfo>.from(body.map((data) => CityInfo.fromJson(data)));
      }
    } catch (e) {
      // log('error: $e');
    }
    return cities;
  }
}
