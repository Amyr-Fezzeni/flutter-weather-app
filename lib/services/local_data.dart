import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/theme.dart';
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

  static saveWeatherData(WeatherModel data) {
    List<dynamic> cities = _box.get('cities', defaultValue: []);
    cities.removeWhere((c) => c['city']['id'] == data.city.id);
    cities.add(data.toJson());
    _box.put('cities', cities);
  }

  static removeWeatherData(WeatherModel data) {
    List<dynamic> cities = _box.get('cities', defaultValue: []);
    cities.removeWhere((c) => c['city']['id'] == data.city.id);
    _box.put('cities', cities);
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
