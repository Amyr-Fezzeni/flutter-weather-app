import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service pour gérer les fonctionnalités de localisation.
///
/// Utilise le package Geolocator pour accéder à la position actuelle de l'appareil
/// et gérer les autorisations de localisation.
///
/// Dépendances:
/// - geolocator: ^7.1.0
///
/// Exemple d'utilisation:
/// ```dart
/// Position? currentLocation = await LocationService.requestLocation();
/// bool hasPermission = await LocationService.requestLocationPermission();
/// ```
class LocationService {
  
  /// Demande la position actuelle de l'appareil.
  ///
  /// Renvoie `null` si l'autorisation de localisation n'est pas accordée.
  static Future<Position?> requestLocation() async {
    try {
      if (!await requestLocationPermission()) {
        return null;
      }
      final Position location = await Geolocator.getCurrentPosition();
      return location;
    } on Exception {
      return null;
    }
  }

  /// Demande l'autorisation de localisation à l'utilisateur.
  ///
  /// Ouvre les paramètres de l'application si les services de localisation ne sont pas activés.
  ///
  /// Renvoie `true` si l'autorisation est accordée pour une utilisation en cours ou permanente.
  static Future<bool> requestLocationPermission() async {
    await Geolocator.requestPermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      return true;
    } else {
      openAppSettings();
    }
    LocationPermission permission = await Geolocator.checkPermission();
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
