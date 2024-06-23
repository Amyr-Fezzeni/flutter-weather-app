// import 'package:timezone/data/latest.dart' as tz;
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
  List<WeatherModel> allCityList = [];
  Map<int, GlobalKey> keys = {};
  int currentCityIndex = 0;

  changeDefaultLanguage(LanguageModel language) {
    if (currentLanguage == language) return;
    currentLanguage = language;
    LocalData.saveAppLanguage(language);
    notifyListeners();
    updateWeatherData();
  }

  void getCityLists() {
    allCityList = [];
    keys.clear();
    if (mainCity != null) allCityList.add(mainCity!);
    allCityList.addAll(cityList);
    for (var city in allCityList) {
      keys[city.city.id] = GlobalObjectKey(city.city.coord);
    }
    if (currentCityIndex >= allCityList.length - 1) {
      currentCityIndex = 0;
    }
  }

  updateCurrentCityIndex(bool toRight) {
    if (allCityList.length < 2) return;
    if (toRight) {
      currentCityIndex--;
      if (currentCityIndex < 0) {
        currentCityIndex = allCityList.length - 1;
      }
    } else {
      currentCityIndex++;
      if (currentCityIndex >= allCityList.length) {
        currentCityIndex = 0;
      }
    }
    notifyListeners();
  }

  updateCurrentCityIndexByIndex(int index) {
    if (allCityList.length <= index) return;
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
    getCityLists();
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
    WeatherModel? cityData;
    String req = [city.name, city.state, city.country]
        .where((e) => e != null)
        .join(', ');

    if (city.lat != null && city.lon != null) {
      cityData = await ApiService.getForecastWeatherDataByCordinate(
        lat: city.lat!,
        lon: city.lon!,
        lang: currentLanguage.name.substring(0, 2),
      );
    } else if (req.isNotEmpty) {
      cityData = await ApiService.getForecastWeatherDataByCity(
        city: "${city.name}, ${city.state}, ${city.country}",
        lang: currentLanguage.name.substring(0, 2),
      );
    }

    if (cityData == null) {
      customPopup(
          message:
              "Sorry we don't have data for this city at this moment, please try later.");
      return;
    }
    if (keys.keys.contains(cityData.city.id)) {
      customPopup(message: 'City already exist!');
      return;
    }
    LocalData.saveWeatherData(cityData);
    cityList.add(cityData);
    getCityLists();
    notifyListeners();
    NavigationService.navigatorKey.currentContext!.pop();
  }

  Future<void> removeCities(List<int> ids) async {
    cityList.removeWhere((city) => ids.contains(city.city.id));
    LocalData.saveAllWeatherData(cityList);
    getCityLists();
    notifyListeners();
  }

  Future<void> initData() async {
    currentLanguage = LocalData.getAppLanguage();
    temperatureUnit = LocalData.getWeatherParams(key: 'temp');
    windSpeedUnit = LocalData.getWeatherParams(key: 'wind');
    atmospherePressureUnit = LocalData.getWeatherParams(key: 'pressure');
    mainCity = LocalData.getMainWeather();
    cityList = LocalData.getSavedWeather();
    getCityLists();

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
        getCityLists();
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
    getCityLists();
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
    getCityLists();
    notifyListeners();
  }
}
