import 'package:flutter/material.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/navigation_service.dart';

/// Fournit la gestion des villes sélectionnées dans l'application.
///
/// Ce modèle de fournisseur gère l'état de la gestion des villes sélectionnées,
/// permettant d'ajouter, de supprimer et de mettre à jour les villes sélectionnées.
class ManageCityProvider with ChangeNotifier {
  bool manageCities = false;
  List<int> selectedCities = [];

  /// Met à jour l'état de la gestion des villes.
  ///
  /// Si la valeur est la même que celle actuelle, aucune action n'est entreprise.
  /// Met à jour l'état de gestion des villes et réinitialise les villes sélectionnées si nécessaire.
  updateManageCities(bool value) {
    if (value == manageCities) return;
    manageCities = value;
    if (!value) {
      selectedCities = [];
    }
    notifyListeners();
  }

  /// Ajoute ou supprime une ville de la liste des villes sélectionnées.
  ///
  /// Si l'identifiant de la ville est déjà présent dans la liste, il est supprimé.
  /// Sinon, il est ajouté à la liste.
  addOrRemodeCity(int id) {
    if (selectedCities.contains(id)) {
      selectedCities.remove(id);
    } else {
      selectedCities.add(id);
    }
    notifyListeners();
  }

  /// Supprime les villes sélectionnées de la source de données.
  ///
  /// Utilise le service de navigation pour accéder au contexte actuel
  /// et supprimer les villes sélectionnées à partir de la source de données.
  /// Ensuite, met à jour l'état de gestion des villes pour désactiver le mode de gestion.
  deleteSelectedCities() {
    NavigationService.navigatorKey.currentContext!.dataRead
        .removeCities(selectedCities);
    updateManageCities(false);
  }

  /// Obtient le titre de la barre de sélection en fonction du nombre de villes sélectionnées.
  getTitle() {
    return selectedCities.isEmpty
        ? "Select items"
        : '${selectedCities.length} ${txt("item${selectedCities.length > 1 ? 's' : ''} selected")}';
  }
}
