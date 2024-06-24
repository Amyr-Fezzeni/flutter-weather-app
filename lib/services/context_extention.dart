import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';
import 'package:weather_app/providers/manage_cities_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/services/page_transitions.dart';

/// Extension de contexte pour Flutter fournissant des méthodes et propriétés utiles.
///
/// Cette extension permet d'accéder facilement aux dimensions de l'écran,
/// aux thèmes de l'application, aux données de l'application et à la gestion des villes.
/// Elle inclut également des méthodes pour la navigation et la gestion des styles d'application.
///
/// Dépendances:
/// - flutter
///
/// Exemple d'utilisation:
/// ```dart
/// double height = context.h;
/// double width = context.w;
/// context.moveTo(MyScreen());
/// ```
extension ContextExt on BuildContext {
  
  /// Hauteur de l'écran en pixels.
  double get h => MediaQuery.of(this).size.height;
  
  /// Largeur de l'écran en pixels.
  double get w => MediaQuery.of(this).size.width;

  /// Fournisseur de thème de l'application pour l'écoute des changements.
  AppThemeProvider get appThemeWatch => watch<AppThemeProvider>();
  
  /// Fournisseur de thème de l'application pour la lecture des données.
  AppThemeProvider get appThemeRead => read<AppThemeProvider>();

  /// Fournisseur de données pour l'écoute des changements.
  DataProvider get dataWatch => watch<DataProvider>();
  
  /// Fournisseur de données pour la lecture des données.
  DataProvider get dataRead => read<DataProvider>();

  /// Fournisseur de gestion des villes pour l'écoute des changements.
  ManageCityProvider get manageCitiesWatch => watch<ManageCityProvider>();
  
  /// Fournisseur de gestion des villes pour la lecture des données.
  ManageCityProvider get manageCitiesRead => read<ManageCityProvider>();

  // Styles de l'application
  
  /// Style de texte défini par le thème de l'application.
  TextStyle get text => appThemeWatch.text;
  
  /// Style de titre défini par le thème de l'application.
  TextStyle get title => appThemeWatch.title;
  
  /// Couleur de fond définie par le thème de l'application.
  Color get bgcolor => appThemeWatch.bgColor;
  
  /// Couleur inversée définie par le thème de l'application.
  Color get invertedColor => appThemeWatch.invertedColor;
  
  /// Couleur des icônes définie par le thème de l'application.
  Color get iconColor => invertedColor.withOpacity(.7);
  
  /// Couleur principale définie par le thème de l'application.
  Color get primaryColor => appThemeWatch.primaryColor;

  // Méthodes de navigation

  /// Navigue vers une nouvelle page en ajoutant une transition de glissement.
  moveTo(Widget screen) => Navigator.push(this, SlideTransition1(screen));

  /// Remplace l'écran actuel par une nouvelle page.
  replaceWith(Widget screen) => Navigator.pushReplacement(
      this, MaterialPageRoute(builder: (context) => screen));

  /// Navigue vers une nouvelle page et supprime l'historique de navigation.
  moveToAndRemoveHistory(Widget screen) =>
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => screen),
          (Route<dynamic> route) => false);

  /// Affiche un écran pop-up en bas de l'écran.
  showPopUpScreen(Widget screen) => showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: this,
      isScrollControlled: true,
      builder: (context) => screen);
  
  /// Ferme l'écran pop-up actuel et retourne à l'écran précédent.
  pop() => Navigator.pop(this);
}
