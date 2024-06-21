import 'dart:convert';

class WeatherWind {
  double? speed;
  double? deg;
  double? gust;
  WeatherWind({
    this.speed,
    this.deg,
    this.gust,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }

  factory WeatherWind.fromMap(Map<String, dynamic> map) {
    return WeatherWind(
      speed: double.tryParse(map['speed'].toString()),
      deg: double.tryParse(map['deg'].toString()),
      gust: double.tryParse(map['gust'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherWind.fromJson(String source) =>
      WeatherWind.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WeatherWind(speed: $speed, deg: $deg, gust: $gust)';
}
