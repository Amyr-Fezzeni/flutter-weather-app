// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'coord.dart';

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final DateTime sunrise;
  final DateTime sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(Map<String, dynamic>.from(json['coord'])),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise:
          DateTime.fromMillisecondsSinceEpoch((json['sunrise'] * 1000).toInt(), isUtc: true),
      sunset:
          DateTime.fromMillisecondsSinceEpoch((json['sunset'] * 1000).toInt(), isUtc: true),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toJson(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise.millisecondsSinceEpoch ~/ 1000,
      'sunset': sunset.millisecondsSinceEpoch ~/ 1000,
    };
  }

  @override
  String toString() {
    return 'City(id: $id, name: $name, coord: $coord, country: $country, population: $population, timezone: $timezone, sunrise: $sunrise, sunset: $sunset)';
  }

  @override
  bool operator ==(covariant City other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.coord == coord &&
        other.country == country &&
        other.timezone == timezone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coord.hashCode ^
        country.hashCode ^
        timezone.hashCode;
  }
}
