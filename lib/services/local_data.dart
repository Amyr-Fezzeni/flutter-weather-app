import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/constants/const_data.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/theme.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
/// A class that handles local data storage using Hive.
///
/// Uses Hive for local database operations and stores various weather,
/// unit settings, theme, and language preferences.
///
/// Dependencies:
/// - hive: ^2.0.4
/// - path_provider: ^2.0.5
/// - weather_app/constants/const_data.dart
/// - weather_app/models/language.dart
/// - weather_app/models/theme.dart
/// - weather_app/models/unit_model.dart
/// - weather_app/models/weather_model/weather_model.dart
///
/// Example usage:
/// ```dart
/// await LocalData.init();
/// LocalData.saveWeatherData(weatherModel);
/// WeatherModel? mainWeather = LocalData.getMainWeather();
/// ```
///
/// Note: Ensure to call `LocalData.init()` before using other methods.
class LocalData {
  static late final Box _box;

  /// Initializes Hive and opens the 'myData' box for storing data.
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.openBox('myData');
    _box = Hive.box('myData');
  }

  /// Retrieves a list of saved weather data from local storage.
  static List<WeatherModel> getSavedWeather() {
    return List<WeatherModel>.from(_box.get('cities', defaultValue: []).map(
        (data) => WeatherModel.fromJson(Map<String, dynamic>.from(data))));
  }

  /// Retrieves the main weather data stored in local storage.
  static WeatherModel? getMainWeather() {
    final mainCity = _box.get('mainCity');
    if (mainCity != null) {
      return WeatherModel.fromJson(Map<String, dynamic>.from(mainCity));
    }
    return null;
  }

  /// Saves weather data to local storage. Optionally marks it as main city.
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

  /// Saves all weather data to local storage.
  static saveAllWeatherData(List<WeatherModel> cities) {
    _box.put('cities', cities.map((e) => e.toJson()).toList());
  }

  /// Removes weather data from local storage.
  static removeWeatherData(WeatherModel data) {
    List<dynamic> cities = _box.get('cities', defaultValue: []);
    cities.removeWhere((c) => c['city']['id'] == data.city.id);
    _box.put('cities', cities);
  }

  /// Saves unit settings parameters to local storage.
  static saveWeatherParams({required String key, required UnitModel unit}) {
    _box.put(key, unit.toMap());
  }

  /// Retrieves unit settings parameters from local storage.
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

  /// Saves the selected app theme to local storage.
  static saveAppTheme(AppThemeModel value) {
    _box.put('appTheme', value.name);
  }

  /// Retrieves the currently selected app theme from local storage.
  static AppThemeModel getAppTheme() {
    return getAppThemeFromString(
        _box.get('appTheme', defaultValue: AppThemeModel.system.name));
  }

  /// Saves the selected app language to local storage.
  static saveAppLanguage(LanguageModel language) {
    _box.put('appLanguage', language.name);
  }

  /// Retrieves the currently selected app language from local storage.
  static LanguageModel getAppLanguage() {
    return getLanguageFromString(
        _box.get('appLanguage', defaultValue: LanguageModel.french.name));
  }
}
