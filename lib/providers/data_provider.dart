import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/const_data.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/location_service.dart';

class DataProvider with ChangeNotifier {
  List<City> cityList = [];
  LanguageModel currentLanguage = LanguageModel.french;
  UnitModel temperatureUnit = temperatureList.first;
  UnitModel windSpeedUnit = windSpeedList.first;
  UnitModel atmospherePressureUnit = atmospherePressureList.first;

  changeTemperatureUnit(UnitModel unit) {
    temperatureUnit = unit;
    notifyListeners();
  }

  changeWindSpeedUnit(UnitModel unit) {
    windSpeedUnit = unit;
    notifyListeners();
  }

  changeatmospherePressureUnit(UnitModel unit) {
    atmospherePressureUnit = unit;
    notifyListeners();
  }

  Future<dynamic> getListCities(String query) async {
    return await ApiService.getListCities(query: query);
  }

  Future<void> addCity(City city) async {
    final data = await ApiService.getWeatherData(
        lat: city.latitude,
        lon: city.longitude,
        lang: currentLanguage.name.substring(0, 2));
    log(data.toString());
    cityList.add(city);
    notifyListeners();
  }

  Future<void> removeCity() async {}

  Future<void> initData() async {}

  Future<void> getCurrentLocation() async {
    final data = await LocationService.requestLocation();
    log("Location: $data");
  }
}
