import 'package:flutter/material.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/navigation_service.dart';

class ManageCityProvider with ChangeNotifier {
  bool manageCities = false;
  List<int> selectedCities = [];

  updateManageCities(bool value) {
    if (value == manageCities) return;
    manageCities = value;
    if (!value) {
      selectedCities = [];
    }
    notifyListeners();
  }

  addOrRemodeCity(int id) {
    if (selectedCities.contains(id)) {
      selectedCities.remove(id);
    } else {
      selectedCities.add(id);
    }
    notifyListeners();
  }

  deleteSelectedCities() {
    NavigationService.navigatorKey.currentContext!.dataRead
        .removeCities(selectedCities);
    updateManageCities(false);
  }

  getTitle() {
    return selectedCities.isEmpty
        ? "Select items"
        : '${selectedCities.length} ${txt("item${selectedCities.length > 1 ? 's' : ''} selected")}';
  }
}
