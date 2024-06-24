import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/services/api_service.dart';

void main() {
  test('Fetch weather data for a city', () async {
    final weather = await ApiService.getForecastWeatherDataByCity(
        city: 'London',
        language: 'fr',
        key: '8a5a3199b6e7e613a513c01b0a868ee7');
    expect(weather, isNotNull);
    expect(weather?.city, isNotNull);
  });
}
