import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/services/location_service.dart';

class DataProvider with ChangeNotifier {
  Future<void> addCity() async {}

  Future<void> removeCity() async {}

  Future<void> initData() async {}

  Future<void> getCurrentLocation() async {
    final data = await LocationService.requestLocation();
    log("Location: $data");
  }
}
