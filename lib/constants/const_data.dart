import 'package:weather_app/models/unit_model.dart';

List<UnitModel> temperatureList = [
  UnitModel(name: '°C', code: 'C', description: "°C"),
  UnitModel(name: '°F', code: 'F', description: "°F")
];

List<UnitModel> windSpeedList = [
  UnitModel(
      name: 'Kilometers per hour (km/h)',
      code: 'kmh',
      description: "Kilometers per hour (km/h)"),
  UnitModel(
      name: 'Miles per hour (mph)',
      code: 'mph',
      description: "Miles per hour (mph)"),
  UnitModel(
      name: 'Meters per second (m/s)',
      code: 'ms',
      description: "Meters per second (m/s)"),
  UnitModel(
      name: 'Feet per second (ft/s)',
      code: 'fts',
      description: "Feet per second (ft/s)"),
  UnitModel(name: 'Knots (kt)', code: 'kt', description: "Knots (kt)"),
];

List<UnitModel> atmospherePressureList = [
  UnitModel(name: 'Millibars (mb)', code: 'C', description: "Millibars (mb)"),
  UnitModel(
      name: 'Inch of mercury (inHg)',
      code: 'inHg',
      description: "Inch of mercury (inHg)"),
  UnitModel(
      name: 'Standard atmospheres (atm)',
      code: 'atm',
      description: "Standard atmospheres (atm)")
];
