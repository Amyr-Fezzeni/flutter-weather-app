import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const apiUrl = "https://api.openweathermap.org/data/2.5/onecall";

  // static String urlParam(
  //         {required double lat, required double lon, required String lang}) =>
  //     "$apiUrl?lat=$lat&lon=$lon&lan=$lang&appid=${dotenv.get('API_KEY')}";

  static Future<Map<String, dynamic>> getWeatherData(
      {required double lat, required double lon, required String lang}) async {
    try {
      log(dotenv.get('API_KEY'));
      final http.Response request = await http.get(
          Uri.parse(
              "$apiUrl?lat=$lat&lon=$lon&lang=$lang&appid=${dotenv.get('API_KEY')}"),
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
}
