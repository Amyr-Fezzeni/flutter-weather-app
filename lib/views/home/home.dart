import 'package:flutter/material.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/views/city/manage_cities.dart';
import 'package:weather_app/views/home/weather_details.dart';
import 'package:weather_app/views/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.appThemeRead.initTheme();
    context.dataRead.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.bgcolor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => context.moveTo(const ManageCities()),
            icon: const Icon(Icons.add, color: Colors.white, size: 25),
            tooltip: txt('Add city'),
          ),
          IconButton(
            onPressed: () => context.moveTo(const Settings()),
            icon: const Icon(Icons.more_vert_rounded,
                color: Colors.white, size: 25),
            tooltip: txt('Settings'),
          )
        ],
      ),
      body: WeatherDetails(
        weatherData: context.dataWatch.cityList[0],
      ),
    );
  }
}
