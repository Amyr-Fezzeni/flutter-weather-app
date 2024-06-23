import 'package:weather_app/models/unit_model.dart';

const appName = 'Weather App';

List<UnitModel> temperatureList = [
  UnitModel(name: '°C', code: 'C', description: "°C"),
  UnitModel(name: '°F', code: 'F', description: "°F")
];

List<UnitModel> windSpeedList = [
  UnitModel(
      name: '(km/h)', code: 'km/h', description: "Kilometers per hour (km/h)"),
  UnitModel(
      name: 'Miles per hour (mph)',
      code: 'mp/h',
      description: "Miles per hour (mph)"),
  UnitModel(name: '(m/s)', code: 'm/s', description: "Meters per second (m/s)"),
  UnitModel(
      name: '(ft/s)', code: 'ft/s', description: "Feet per second (ft/s)"),
  UnitModel(name: '(kt)', code: 'kt', description: "Knots (kt)"),
];

List<UnitModel> atmospherePressureList = [
  UnitModel(name: '(mb)', code: 'mb', description: "Millibars (mb)"),
  UnitModel(
      name: '(inHg)', code: 'inHg', description: "Inch of mercury (inHg)"),
  UnitModel(
      name: '(atm)', code: 'atm', description: "Standard atmospheres (atm)")
];
