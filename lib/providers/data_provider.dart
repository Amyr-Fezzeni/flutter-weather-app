import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/local_data.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:weather_app/widgets/popup.dart';

class DataProvider with ChangeNotifier {
  late LanguageModel currentLanguage;
  late UnitModel temperatureUnit;
  late UnitModel windSpeedUnit;
  late UnitModel atmospherePressureUnit;

  WeatherModel? mainCity;
  List<WeatherModel> cityList = [];
  int currentCityIndex = 0;
  List<GlobalKey> keys = [];

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
      currentCityIndex--;
      if (currentCityIndex < 0) {
        currentCityIndex = allData.length - 1;
      }
    } else {
      currentCityIndex++;
      if (currentCityIndex >= allData.length) {
        currentCityIndex = 0;
      }
    }
    notifyListeners();
  }

  updateCurrentCityIndexByIndex(int index) {
    final allData = getCityList();
    if (allData.length <= index) return;

    currentCityIndex = index;

    notifyListeners();
  }

  orderCities(oldIndex, newIndex) async {
    List<WeatherModel> cities = LocalData.getSavedWeather();
    final id = cities.removeAt(oldIndex);
    if (newIndex >= cities.length) {
      cities.add(id);
    } else {
      cities.insert(newIndex, id);
    }
    cityList = cities;
    LocalData.saveAllWeatherData(cities);
    notifyListeners();
  }

  changeTemperatureUnit(UnitModel unit) {
    temperatureUnit = unit;
    notifyListeners();
    LocalData.saveWeatherParams(key: 'temp', unit: unit);
  }

  changeWindSpeedUnit(UnitModel unit) {
    windSpeedUnit = unit;
    notifyListeners();
    LocalData.saveWeatherParams(key: 'wind', unit: unit);
  }

  changeatmospherePressureUnit(UnitModel unit) {
    atmospherePressureUnit = unit;
    notifyListeners();
    LocalData.saveWeatherParams(key: 'pressure', unit: unit);
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
            city: "${city.name},${city.state},${city.country}",
            lang: currentLanguage.name.substring(0, 2),
          );

    if (cityData == null) {
      
      return;}
    if (cityList.map((city) => city.city.id).contains(cityData.city.id)) {
      customPopup();
      return;
    }
    LocalData.saveWeatherData(cityData);
    cityList.add(cityData);
    notifyListeners();
    NavigationService.navigatorKey.currentContext!.pop();
  }

  Future<void> removeCities(List<int> ids) async {
    cityList.removeWhere((city) => ids.contains(city.city.id));
    LocalData.saveAllWeatherData(cityList);
    notifyListeners();
  }

  Future<void> initData() async {
    currentLanguage = LocalData.getAppLanguage();
    temperatureUnit = LocalData.getWeatherParams(key: 'temp');
    windSpeedUnit = LocalData.getWeatherParams(key: 'wind');
    atmospherePressureUnit = LocalData.getWeatherParams(key: 'pressure');
    mainCity = LocalData.getMainWeather();
    cityList = LocalData.getSavedWeather();

    keys = getCityList()
        .map((e) => GlobalKey(debugLabel: e.city.id.toString()))
        .toList();
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
