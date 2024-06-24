import 'package:weather_app/constants/background_data.dart';

/// Capitalise la première lettre d'une chaîne de caractères et met le reste en minuscules.
///
/// Retourne une chaîne vide si [text] est nul ou vide.
String capitalize(String? text) {
  if (text == null || text.isEmpty) return '';
  return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
}

/// Renvoie le chemin d'accès à l'icône météo dans les ressources.
///
/// Utilise [icon] pour construire le chemin d'accès à l'icône dans le dossier 'assets/weather icons'.
String getAssetIcon(String icon) => "assets/weather icons/$icon.png";

/// Calcule la moyenne des nombres dans [numbers].
///
/// Renvoie 0 si [numbers] est vide.
int getAverageNumber(List<int> numbers) {
  if (numbers.isEmpty) return 0;
  int sum = numbers.reduce((a, b) => a + b);
  return sum ~/ numbers.length;
}

/// Renvoie les détails de la date sous forme de map pour une [date] donnée.
///
/// Le jour est étiqueté comme 'Today', 'Tomorrow' ou le nom du jour de la semaine.
Map<String, dynamic> getDateDetails(DateTime date) {
  List<String> dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  DateTime today = DateTime.now();
  DateTime tomorrow = today.add(const Duration(days: 1));

  String dayName;

  if (date.year == today.year &&
      date.month == today.month &&
      date.day == today.day) {
    dayName = 'Today';
  } else if (date.year == tomorrow.year &&
      date.month == tomorrow.month &&
      date.day == tomorrow.day) {
    dayName = 'Tomorrow';
  } else {
    dayName = dayNames[date.weekday % 7];
  }
  return {
    'date': "${date.month}/${date.day}",
    'day': date.day,
    'month': date.month,
    'dayName': dayName
  };
}

/// Renvoie la vitesse moyenne du vent à partir d'une liste de données de vent [windList].
///
/// Renvoie un map vide si [windList] est vide.
Map<String, dynamic> getAverageWindSpeed(List<Map<String, dynamic>> windList) {
  if (windList.isEmpty) return {};
  windList.sort((a, b) => (a['speed'] as double).compareTo(b['speed']));
  return windList[(windList.length / 2).floor()];
}

/// Renvoie l'arrière-plan météo correspondant à [main] et [isDay].
///
/// Utilise les constantes d'arrière-plan définies pour différents types de conditions météorologiques.
String weatherBackgroung(String main, bool isDay) {
  switch (main) {
    case 'Clear':
      return isDay ? clearDay : clearNight;
    case 'Clouds':
      return isDay ? fewCloudsDay : fewCloudsNight;
    case 'Rain':
      return isDay ? cloudsDay : cloudsNight;
    default:
      return fewCloudsDay;
  }
}

/// Renvoie l'arrière-plan de la carte météo correspondant à [main] et [isDay].
///
/// Utilise les constantes d'arrière-plan de carte définies pour différents types de conditions météorologiques.
String weatherBackgroungCard(String main, bool isDay) {
  switch (main) {
    case 'Clear':
      return isDay ? clearDayCard : clearNightCard;
    case 'Clouds':
      return isDay ? fewCloudsDayCard : fewCloudsNightCard;
    case 'Rain':
      return isDay ? cloudsCard : cloudsNight;
    default:
      return fewCloudsDay;
  }
}
