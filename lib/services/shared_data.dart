import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/theme.dart';

class DataPrefrences {
  static late SharedPreferences _preferences;
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> setDarkMode(AppThemeModel value) async =>
      await _preferences.setString("darkMode", value.name);

  static String getDarkMode() => _preferences.getString('darkMode') ?? "dark";

  static Future<void> setDefaultLanguage(String code) async =>
      await _preferences.setString("language", code);

  static LanguageModel getDefaultLanguage() =>
      getLanguageFromString(_preferences.getString('language') ?? "french");
}
