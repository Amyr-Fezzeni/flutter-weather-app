import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/constants/const_data.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/local_data.dart';

class DataProvider with ChangeNotifier {
  LanguageModel currentLanguage = LanguageModel.french;
  late final Box box;
  List<WeatherModel> cityList = [];
  WeatherModel? mainCity;
  int currentCityIndex = 0;

  UnitModel temperatureUnit = temperatureList.first;
  UnitModel windSpeedUnit = windSpeedList.first;
  UnitModel atmospherePressureUnit = atmospherePressureList.first;

  changeDefaultLanguage(LanguageModel language) {
    currentLanguage = language;
    LocalData.saveAppLanguage(language);
    notifyListeners();
  }

  List<WeatherModel> getCityList() {
    List<WeatherModel> allData = [];
    if (mainCity != null) {
      allData.add(mainCity!);
    }
    allData.addAll(cityList);
    return allData;
  }

  updateCurrentCityIndex(bool toRight) {
    final allData = getCityList();
    if (allData.length < 2) return;
    if (toRight) {
      currentCityIndex += 1;
      if (allData.length >= currentCityIndex) {
        currentCityIndex = 0;
      }
    } else {
      currentCityIndex -= 1;
      if (currentCityIndex < 0) {
        currentCityIndex = allData.length - 1;
      }
    }
    notifyListeners();
  }

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

  Future<void> addCity(CityInfo city) async {
    log(city.toString());
    WeatherModel? cityData = (city.name ?? '').isEmpty
        ? await ApiService.getForecastWeatherDataByCordinate(
            lat: city.lat!,
            lon: city.lon!,
            lang: currentLanguage.name.substring(0, 2),
          )
        : await ApiService.getForecastWeatherDataByCity(
            city: "${city.name!},${city.state!},${city.country!}",
            lang: currentLanguage.name.substring(0, 2),
          );

    if (cityData != null) {
      log(cityData.toString());
      LocalData.saveWeatherData(cityData);
      cityList.add(cityData);
      notifyListeners();
    }
  }

  Future<void> removeCity(WeatherModel city) async {
    cityList.removeWhere((c) => c.city.id == city.city.id);
    LocalData.removeWeatherData(city);
    notifyListeners();
  }

  Future<void> initData() async {
    currentLanguage = LocalData.getAppLanguage();
    mainCity = LocalData.getMainWeather();
    cityList = LocalData.getSavedWeather();

    await getCurrentLocation();
    updateWeatherData();
  }

  updateWeatherData() async {
    if (mainCity != null) {
      final cityData = await ApiService.getForecastWeatherDataByCordinate(
          lat: mainCity!.city.coord.lat,
          lon: mainCity!.city.coord.lon,
          lang: currentLanguage.name.substring(0, 2));
      if (cityData != null) {
        mainCity = cityData;
        LocalData.saveWeatherData(cityData, isMain: true);
        notifyListeners();
      }
    }
    List<WeatherModel> newCitiesData = [];
    for (var city in cityList) {
      final cityData = await ApiService.getForecastWeatherDataByCordinate(
          lat: city.city.coord.lat,
          lon: city.city.coord.lon,
          lang: currentLanguage.name.substring(0, 2));
      if (cityData == null) continue;
      newCitiesData.add(cityData);
    }
    cityList = newCitiesData;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    final data = await LocationService.requestLocation();
    log(data.toString());
    if (data == null) return;
    WeatherModel? cityData = await ApiService.getForecastWeatherDataByCordinate(
        lat: data.latitude,
        lon: data.longitude,
        lang: currentLanguage.name.substring(0, 2));
    if (cityData == null) return;

    LocalData.saveWeatherData(cityData, isMain: true);
    mainCity = cityData;
    notifyListeners();
  }
}
