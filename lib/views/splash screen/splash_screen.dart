import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/ext.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.appthemeRead.initTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(50),
                ElevatedButton(
                    onPressed: () {
                      context.dataRead.getCurrentLocation();
                    },
                    child: const Text('Get Location')),
                const Gap(20),
                ElevatedButton(
                    onPressed: () {
                      ApiService.getWeatherData(
                          lat: 36.7782676, lon: 10.0767259, lang: 'fr');
                    },
                    child: const Text('Get Wather data')),
              ],
            ),
          )),
    );
  }
}
