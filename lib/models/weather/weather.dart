// import 'dart:convert';

// import 'main_weather.dart';
// import 'weather_info.dart';
// import 'weather_sys.dart';
// import 'weather_wind.dart';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class CityWeather {
//   int id;
//   int timeZone;
//   String name;
//   String displayName;
//   DateTime dt;
//   double latitude;
//   double longitude;
//   List<WeatherInfo> weatherInfo;
//   MainWeather mainWeather;
//   WeatherWind weatherWind;
//   WeatherSys weatherSys;

//   CityWeather(
//       {required this.id,
//       required this.timeZone,
//       required this.name,
//       required this.dt,
//       required this.latitude,
//       required this.longitude,
//       required this.weatherInfo,
//       required this.mainWeather,
//       required this.weatherSys,
//       required this.weatherWind,
//       this.displayName = ''});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'timeZone': timeZone,
//       'name': name,
//       'dt': dt.millisecondsSinceEpoch,
//       'weatherInfo': weatherInfo.map((x) => x.toMap()).toList(),
//       'mainWeather': mainWeather.toMap(),
//       'weatherSys': weatherSys.toMap(),
//       'weatherWind': weatherWind.toMap(),
//       'displayName': displayName,
//       'latitude': latitude,
//       'longitude': longitude,
//     };
//   }

//   factory CityWeather.fromMap(Map<String, dynamic> map) {
//     return CityWeather(
//         id: map['id'] as int,
//         latitude: double.parse(map['latitude'].toString()),
//         longitude: double.parse(map['longitude'].toString()),
//         timeZone: map['timeZone'],
//         name: map['name'] as String,
//         displayName: map['displayName'] ?? '',
//         dt: DateTime.fromMillisecondsSinceEpoch(map['dt'] * 1000),
//         weatherInfo: List<WeatherInfo>.from((map['weatherInfo'] ?? [])
//             .map((x) => WeatherInfo.fromMap(Map<String, dynamic>.from(x)))),
//         mainWeather:
//             MainWeather.fromMap(Map<String, dynamic>.from(map['mainWeather'])),
//         weatherSys:
//             WeatherSys.fromMap(Map<String, dynamic>.from(map['weatherSys'])),
//         weatherWind:
//             WeatherWind.fromMap(Map<String, dynamic>.from(map['weatherWind'])));
//   }
//   factory CityWeather.fromApi(Map<String, dynamic> map) {
//     return CityWeather(
//         id: map['id'] as int,
//         latitude: double.parse(map['coord']['lat'].toString()),
//         longitude: double.parse(map['coord']['lon'].toString()),
//         timeZone: map['timezone'] as int,
//         name: map['name'] as String,
//         displayName: map['displayName'] ?? '',
//         dt: DateTime.fromMillisecondsSinceEpoch(map['dt'] as int),
//         weatherInfo: List<WeatherInfo>.from((map['weather'] as List<dynamic>)
//             .map<WeatherInfo>((x) => WeatherInfo.fromMap(x))),
//         mainWeather: MainWeather.fromMap(map['main']),
//         weatherSys: WeatherSys.fromMap(map['sys']),
//         weatherWind: WeatherWind.fromMap(map['wind']));
//   }

//   String toJson() => json.encode(toMap());

//   factory CityWeather.fromJson(String source) =>
//       CityWeather.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'CityWeather(id: $id, timeZone: $timeZone, name: $name, displayName: $displayName, dt: $dt, latitude: $latitude, longitude: $longitude, weatherInfo: $weatherInfo, mainWeather: $mainWeather, weatherWind: $weatherWind, weatherSys: $weatherSys)';
//   }
// }
