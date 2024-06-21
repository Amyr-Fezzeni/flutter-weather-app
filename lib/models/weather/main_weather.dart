import 'dart:convert';

class MainWeather {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  double? pressure;
  double? humidity;
  double? seaLevel;
  double? grndLevel;
  MainWeather({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
    };
  }

  factory MainWeather.fromMap(Map<String, dynamic> map) {
    return MainWeather(
      temp: double.tryParse(map['temp'].toString()),
      feelsLike: double.tryParse(map['feels_like'].toString()),
      tempMin: double.tryParse(map['temp_min'].toString()),
      tempMax: double.tryParse(map['temp_max'].toString()),
      pressure: double.tryParse(map['pressure'].toString()),
      humidity: double.tryParse(map['humidity'].toString()),
      seaLevel: double.tryParse(map['sea_level'].toString()),
      grndLevel: double.tryParse(map['grnd_level'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory MainWeather.fromJson(String source) =>
      MainWeather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MainWeather(temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity, seaLevel: $seaLevel, grndLevel: $grndLevel)';
  }
}
