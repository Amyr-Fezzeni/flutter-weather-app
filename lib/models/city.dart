
class CityInfo {
  String? name;
  String? state;
  String? country;
  double? lat;
  double? lon;
  CityInfo({
    this.name,
    this.state,
    this.country,
    this.lat,
    this.lon,
  });

  @override
  String toString() {
    return 'CityInfo(name: $name, state: $state, country: $country, lat: $lat, lon: $lon)';
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'state': state,
      'country': country,
      'lat': lat,
      'lon': lon,
    };
  }

  factory CityInfo.fromJson(Map<String, dynamic> map) {
    return CityInfo(
      name: map['name'] != null ? map['name'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      lon: map['lon'] != null ? map['lon'] as double : null,
    );
  }

}
