import 'package:weather_app/constants/background_data.dart';

String capitalize(String? text) {
  if (text == null || text.isEmpty) return '';
  return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
}

String getIconUrl(String icon) =>
    "https://openweathermap.org/img/wn/$icon@2x.png";

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

Map<String, dynamic> getAverageWindSpeed(List<Map<String, dynamic>> windList) {
  if (windList.isEmpty) return {};
  windList.sort((a, b) => (a['speed'] as double).compareTo(b['speed']));
  return windList[(windList.length / 2).floor()];
}

String weatherIcon(String description) {
  switch (description) {
    case 'clear sky':
      return "";
    case 'few clouds':
      return "";
    case 'scattered clouds':
      return "";
    case 'broken clouds':
      return "";
    case 'shower rain':
      return "";
    case 'rain':
      return "";
    case 'thunderstorm':
      return "";
    case 'snow':
      return "";
    case 'mist':
      return "";
    default:
      return '';
  }
}

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
