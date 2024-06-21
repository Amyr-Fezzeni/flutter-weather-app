// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherSys {
  String? country;
  DateTime? sunset;
  DateTime? sunrise;
  WeatherSys({
    this.country,
    this.sunset,
    this.sunrise,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'sunset': sunset?.millisecondsSinceEpoch,
      'sunrise': sunrise?.millisecondsSinceEpoch,
    };
  }

  factory WeatherSys.fromMap(Map<String, dynamic> map) {
    return WeatherSys(
      country: map['country'] != null ? map['country'] as String : null,
      sunset: map['sunset'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['sunset'] *1000)
          : null,
      sunrise: map['sunrise'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['sunrise'] *1000)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherSys.fromJson(String source) =>
      WeatherSys.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeatherSys(country: $country, sunset: $sunset, sunrise: $sunrise)';
}
