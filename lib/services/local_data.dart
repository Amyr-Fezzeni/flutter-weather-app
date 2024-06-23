import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/constants/const_data.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/theme.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';

class LocalData {
  static late final Box _box;
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.openBox('myData');
    _box = Hive.box('myData');
  }

  static List<WeatherModel> getSavedWeather() {
    return List<WeatherModel>.from(_box.get('cities', defaultValue: []).map(
        (data) => WeatherModel.fromJson(Map<String, dynamic>.from(data))));
  }

  static WeatherModel? getMainWeather() {
    final mainCity = _box.get('mainCity');
    if (mainCity != null) {
      return WeatherModel.fromJson(Map<String, dynamic>.from(mainCity));
    }
    return null;
  }

  static saveWeatherData(WeatherModel data, {bool isMain = false}) {
    if (isMain) {
      _box.put('mainCity', data.toJson());
    } else {
      List<dynamic> cities = _box.get('cities', defaultValue: []);
      cities.removeWhere((c) => c['city']['id'] == data.city.id);
      cities.add(data.toJson());
      _box.put('cities', cities);
    }
  }

  static saveAllWeatherData(List<WeatherModel> cities) {
    _box.put('cities', cities.map((e) => e.toJson()).toList());
  }

  static removeWeatherData(WeatherModel data) {
    List<dynamic> cities = _box.get('cities', defaultValue: []);
    cities.removeWhere((c) => c['city']['id'] == data.city.id);
    _box.put('cities', cities);
  }

  static saveWeatherParams({required String key, required UnitModel unit}) {
    _box.put(key, unit.toMap());
  }

  static getWeatherParams({required String key}) {
    switch (key) {
      case 'temp':
        return UnitModel.fromMap(Map<String, dynamic>.from(
            _box.get(key, defaultValue: temperatureList.first.toMap())));
      case 'wind':
        return UnitModel.fromMap(Map<String, dynamic>.from(
            _box.get(key, defaultValue: windSpeedList.first.toMap())));
      case 'pressure':
        return UnitModel.fromMap(Map<String, dynamic>.from(
            _box.get(key, defaultValue: atmospherePressureList.first.toMap())));
      default:
    }
  }

  static saveAppTheme(AppThemeModel value) {
    _box.put('appTheme', value.name);
  }

  static AppThemeModel getAppTheme() {
    return getAppThemeFromString(
        _box.get('appTheme', defaultValue: AppThemeModel.system.name));
  }

  static saveAppLanguage(LanguageModel language) {
    _box.put('appLanguage', language.name);
  }

  static LanguageModel getAppLanguage() {
    return getLanguageFromString(
        _box.get('appLanguage', defaultValue: LanguageModel.french.name));
  }
}
