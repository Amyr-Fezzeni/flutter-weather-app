import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<Position?> requestLocation() async {
    try {
      if (!await requestLocationPermition()) {
        return null;
      }
      final Position location = await Geolocator.getCurrentPosition();
      log(location.toString());
      return location;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> requestLocationPermition() async {
    await Geolocator.requestPermission();
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      return true;
    }
    if (!serviceEnabled) {
      openAppSettings();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }
}
