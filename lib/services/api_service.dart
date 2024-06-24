// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/city_info.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';

/// Une classe pour effectuer des appels API afin de récupérer des informations météorologiques et des informations sur les villes.
///
/// Utilise le package http pour les requêtes réseau et le package json pour l'analyse des données.
/// Utilise l'API OpenWeatherMap pour les données météorologiques et les données des villes.
///
/// Exemple d'utilisation:
/// ```dart
/// WeatherModel? weather = await ApiService.getForecastWeatherDataByCity(city: 'London', lang: 'en');
/// List<CityInfo> cities = await ApiService.getListCities(query: 'New York');
/// ```
///
/// Remarque: Assurez-vous de fournir la bonne API_KEY en utilisant dotenv.
class ApiService {
  static const apiUrl = "https://api.openweathermap.org";

  /// Récupère les données météorologiques prévues par coordonnées géographiques.
  static Future<WeatherModel?> getForecastWeatherDataByCordinate({
    required double lat,
    required double lon,
    required String language,
  }) async {
    try {
      final http.Response request = await http.get(
        Uri.parse(
            "$apiUrl/data/2.5/forecast?lat=$lat&lon=$lon&lang=$language&appid=${dotenv.get('API_KEY')}"),
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

  /// Récupère les données météorologiques prévues par nom de ville.
  static Future<WeatherModel?> getForecastWeatherDataByCity({
    required String city,
    required String language,
    String? key
  }) async {
    try {
      final http.Response request = await http.get(
        Uri.parse(
            "$apiUrl/data/2.5/forecast?q=$city&lang=$language&appid=${key??dotenv.get('API_KEY')}"),
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

  /// Récupère une liste de villes correspondant à la requête donnée.
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
