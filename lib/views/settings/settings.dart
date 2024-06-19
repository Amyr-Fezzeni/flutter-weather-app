import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/const_data.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/widgets/appbar.dart';
import 'package:weather_app/widgets/popup.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Settings"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
          child: Column(
            children: [
              settingsPopup(
                  title: "Temperature units",
                  selectedValue: context.dataWatch.temperatureUnit,
                  onTap: (UnitModel unit) =>
                      context.dataRead.changeTemperatureUnit(unit),
                  lst: temperatureList),
              settingsPopup(
                  title: "Wind speed units",
                  selectedValue: context.dataWatch.windSpeedUnit,
                  onTap: (UnitModel unit) =>
                      context.dataRead.changeWindSpeedUnit(unit),
                  lst: windSpeedList),
              settingsPopup(
                  title: "Atmosphere pressure units",
                  selectedValue: context.dataWatch.atmospherePressureUnit,
                  onTap: (UnitModel unit) =>
                      context.dataRead.changeatmospherePressureUnit(unit),
                  lst: atmospherePressureList),
              darkModePopup()
            ],
          ),
        ),
      ),
    );
  }
}
