import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/constants/const_data.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/theme.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';

/// Une classe qui gère le stockage local des données en utilisant Hive.
///
/// Utilise Hive pour les opérations de base de données locale et stocke diverses 
/// données météorologiques, paramètres d'unité, thème et préférences linguistiques.
///
/// Exemple d'utilisation:
/// ```dart
/// await LocalData.init();
/// LocalData.saveWeatherData(weatherModel);
/// WeatherModel? mainWeather = LocalData.getMainWeather();
/// ```
///
/// Remarque: Assurez-vous d'appeler `LocalData.init()` avant d'utiliser d'autres méthodes.
class LocalData {
  static late final Box _box;

  /// Initialise Hive et ouvre la boîte 'myData' pour stocker les données.
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.openBox('myData');
    _box = Hive.box('myData');
  }

  /// Récupère une liste des données météorologiques sauvegardées à partir du stockage local.
  static List<WeatherModel> getSavedWeather() {
    return List<WeatherModel>.from(_box.get('cities', defaultValue: []).map(
        (data) => WeatherModel.fromJson(Map<String, dynamic>.from(data))));
  }

  /// Récupère les données météorologiques principales stockées dans le stockage local.
  static WeatherModel? getMainWeather() {
    final mainCity = _box.get('mainCity');
    if (mainCity != null) {
      return WeatherModel.fromJson(Map<String, dynamic>.from(mainCity));
    }
    return null;
  }

  /// Sauvegarde les données météorologiques dans le stockage local. Optionnellement, les marque comme ville principale.
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

  /// Sauvegarde toutes les données météorologiques dans le stockage local.
  static saveAllWeatherData(List<WeatherModel> cities) {
    _box.put('cities', cities.map((e) => e.toJson()).toList());
  }

  /// Supprime les données météorologiques du stockage local.
  static removeWeatherData(WeatherModel data) {
    List<dynamic> cities = _box.get('cities', defaultValue: []);
    cities.removeWhere((c) => c['city']['id'] == data.city.id);
    _box.put('cities', cities);
  }

  /// Sauvegarde les paramètres des unités dans le stockage local.
  static saveWeatherParams({required String key, required UnitModel unit}) {
    _box.put(key, unit.toMap());
  }

  /// Récupère les paramètres des unités à partir du stockage local.
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

  /// Sauvegarde le thème de l'application sélectionné dans le stockage local.
  static saveAppTheme(AppThemeModel value) {
    _box.put('appTheme', value.name);
  }

  /// Récupère le thème de l'application actuellement sélectionné à partir du stockage local.
  static AppThemeModel getAppTheme() {
    return getAppThemeFromString(
        _box.get('appTheme', defaultValue: AppThemeModel.system.name));
  }

  /// Sauvegarde la langue de l'application sélectionnée dans le stockage local.
  static saveAppLanguage(LanguageModel language) {
    _box.put('appLanguage', language.name);
  }

  /// Récupère la langue de l'application actuellement sélectionnée à partir du stockage local.
  static LanguageModel getAppLanguage() {
    return getLanguageFromString(
        _box.get('appLanguage', defaultValue: LanguageModel.french.name));
  }
}

