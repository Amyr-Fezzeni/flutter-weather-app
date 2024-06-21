// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherInfo {
  int id;
  String main;
  String description;
  String icon;
  WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherInfo.fromMap(Map<String, dynamic> map) {
    return WeatherInfo(
      id: map['id'] as int,
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherInfo.fromJson(String source) =>
      WeatherInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherInfo(id: $id, main: $main, description: $description, icon: $icon)';
  }
}
