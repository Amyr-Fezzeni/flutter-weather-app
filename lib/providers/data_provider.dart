// import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:weather_app/models/city_info.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/local_data.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:weather_app/widgets/popup.dart';

/// Fournit les données et la gestion des paramètres météorologiques pour l'application.
///
/// Ce modèle de fournisseur gère les langues, les unités de mesure (température, vitesse du vent, pression atmosphérique),
/// les villes principales et les listes de villes, ainsi que la gestion des index de ville actuelle.
class DataProvider with ChangeNotifier {
  late LanguageModel currentLanguage; // Langue actuelle de l'application
  late UnitModel temperatureUnit; // Unité de mesure de la température
  late UnitModel windSpeedUnit; // Unité de mesure de la vitesse du vent
  late UnitModel atmospherePressureUnit; // Unité de mesure de la pression atmosphérique

  WeatherModel? mainCity; // Données météorologiques de la ville principale
  List<WeatherModel> cityList = []; // Liste des villes ajoutées par l'utilisateur
  List<WeatherModel> allCityList = []; // Liste complète de toutes les villes (y compris la ville principale et les villes ajoutées)
  Map<int, GlobalKey> keys = {}; // Clés globales pour chaque ville
  int currentCityIndex = 0; // Index de la ville actuellement sélectionnée

  /// Change la langue par défaut de l'application.
  ///
  /// Met à jour la langue actuelle et notifie les auditeurs de changement.
  /// Enregistre également la langue dans le stockage local et met à jour les données météorologiques.
  changeDefaultLanguage(LanguageModel language) {
    if (currentLanguage == language) return;
    currentLanguage = language;
    LocalData.saveAppLanguage(language);
    notifyListeners();
    updateWeatherData();
  }

  /// Récupère la liste complète des villes.
  ///
  /// Met à jour [allCityList] en y ajoutant la ville principale suivie de la liste des villes ajoutées par l'utilisateur.
  /// Associe chaque ville à une clé globale pour une identification unique.
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

  /// Met à jour l'index de la ville actuellement sélectionnée.
  ///
  /// Si [toRight] est vrai, l'index est décrémenté, sinon il est incrémenté.
  /// Notifie les auditeurs de changement.
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

  /// Met à jour l'index de la ville actuellement sélectionnée par l'index donné.
  ///
  /// Si l'index est supérieur ou égal à la taille de [allCityList], aucune action n'est entreprise.
  /// Notifie les auditeurs de changement.
  updateCurrentCityIndexByIndex(int index) {
    if (allCityList.length <= index) return;
    currentCityIndex = index;
    notifyListeners();
  }

  /// Réordonne les villes dans la liste.
  ///
  /// Déplace une ville de l'ancien index [oldIndex] au nouvel index [newIndex].
  /// Sauvegarde la liste réordonnée dans le stockage local, met à jour [cityList] et [allCityList],
  /// puis notifie les auditeurs de changement.
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

  /// Change l'unité de mesure de la température.
  ///
  /// Met à jour [temperatureUnit], notifie les auditeurs de changement
  /// et enregistre la nouvelle unité dans le stockage local.
  changeTemperatureUnit(UnitModel unit) {
    temperatureUnit = unit;
    notifyListeners();
    LocalData.saveWeatherParams(key: 'temp', unit: unit);
  }

  /// Change l'unité de mesure de la vitesse du vent.
  ///
  /// Met à jour [windSpeedUnit], notifie les auditeurs de changement
  /// et enregistre la nouvelle unité dans le stockage local.
  changeWindSpeedUnit(UnitModel unit) {
    windSpeedUnit = unit;
    notifyListeners();
    LocalData.saveWeatherParams(key: 'wind', unit: unit);
  }

  /// Change l'unité de mesure de la pression atmosphérique.
  ///
  /// Met à jour [atmospherePressureUnit], notifie les auditeurs de changement
  /// et enregistre la nouvelle unité dans le stockage local.
  changeatmospherePressureUnit(UnitModel unit) {
    atmospherePressureUnit = unit;
    notifyListeners();
    LocalData.saveWeatherParams(key: 'pressure', unit: unit);
  }

  /// Recherche une liste de villes en fonction de la requête donnée.
  ///
  /// Appelle le service d'API pour récupérer une liste de villes correspondant à la [query].
  Future<dynamic> getListCities(String query) async {
    return await ApiService.getListCities(query: query);
  }

  /// Ajoute une ville à la liste des villes de l'utilisateur.
  ///
  /// Utilise les informations [city] pour obtenir les données météorologiques de la ville,
  /// les sauvegarde localement et les ajoute à [cityList].
  /// Met à jour la liste complète de villes, notifie les auditeurs de changement et ferme l'écran actuel.
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

  /// Supprime les villes correspondant aux identifiants donnés de la liste des villes.
  ///
  /// Utilise les identifiants [ids] pour filtrer et supprimer les villes de [cityList].
  /// Met à jour la liste complète de villes, notifie les auditeurs de changement.
  Future<void> removeCities(List<int> ids) async {
    cityList.removeWhere((city) => ids.contains(city.city.id));
    LocalData.saveAllWeatherData(cityList);
    getCityLists();
    notifyListeners();
  }

  /// Initialise les données de l'application.
  ///
  /// Charge la langue, les paramètres météorologiques, la ville principale et la liste des villes à partir du stockage local.
  /// Obtient les informations météorologiques actuelles en fonction de la localisation de l'utilisateur.
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

  /// Met à jour les données météorologiques pour toutes les villes.
  ///
  /// Met à jour les données météorologiques pour la ville principale et toutes les villes de [cityList].
  /// Notifie les auditeurs de changement après chaque mise à jour.
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

  /// Obtient la localisation actuelle de l'utilisateur et met à jour les données météorologiques pour cette localisation.
  ///
  /// Utilise le service de localisation pour obtenir les coordonnées actuelles de l'utilisateur.
  /// Ensuite, appelle l'API pour obtenir les données météorologiques de cette localisation.
  /// Met à jour les données de la ville principale, notifie les auditeurs de changement.
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
