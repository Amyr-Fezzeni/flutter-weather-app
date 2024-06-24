import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/theme.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:weather_app/services/local_data.dart';

/// Fournit le thème de l'application et gère les modifications de thème.
///
/// Ce modèle de fournisseur de thème gère le thème global de l'application,
/// y compris la couleur d'arrière-plan, les styles de texte, les couleurs inversées,
/// et les couleurs primaires en fonction du thème sélectionné.
///
/// Les fonctions principales incluent la gestion du mode sombre, l'initialisation du thème,
/// la surveillance des changements de thème système et la sauvegarde du thème actuel localement.

class AppThemeProvider with ChangeNotifier {
  AppThemeModel appTheme = AppThemeModel.system;
  Color bgColor = lightBgColor;
  TextStyle text = textstyle;
  TextStyle title = titlestyle;
  bool isDark = false;
  Color invertedColor = darkBgColor;
  Color primaryColor = primaryColorLight;

  /// Obtient le thème du système actuel (clair ou sombre).
  bool getSystemTheme() {
    final brightness =
        MediaQuery.of(NavigationService.navigatorKey.currentContext!)
            .platformBrightness;
    return brightness == Brightness.dark;
  }

  /// Change le mode sombre de l'application.
  ///
  /// Met à jour le thème de l'application en fonction de la valeur fournie.
  /// Sauvegarde également le thème sélectionné localement et démarre
  /// l'écoute des changements de thème.
  void changeDarkMode(AppThemeModel value) async {
    isDark = value == AppThemeModel.system
        ? getSystemTheme()
        : value == AppThemeModel.dark;
    if (isDark) {
      setDarkTheme();
    } else {
      setLightTheme();
    }
    appTheme = value;

    notifyListeners();
    LocalData.saveAppTheme(value);
    startThemeListen();
  }

  /// Initialise le thème de l'application.
  ///
  /// Charge le thème enregistré localement et détermine si le mode sombre est activé.
  /// Démarre l'écoute des changements de thème après un court délai pour notifier les écouteurs.
  initTheme() async {
    appTheme = LocalData.getAppTheme();
    isDark = appTheme == AppThemeModel.system
        ? getSystemTheme()
        : appTheme == AppThemeModel.dark;
    if (isDark) {
      setDarkTheme();
    } else {
      setLightTheme();
    }
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => notifyListeners());
    startThemeListen();
  }

  /// Démarre l'écoute continue des changements de thème système.
  ///
  /// Vérifie périodiquement si le thème du système a changé et ajuste le thème de l'application en conséquence.
  startThemeListen() {
    if (appTheme != AppThemeModel.system) return;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (appTheme != AppThemeModel.system) {
        timer.cancel();
        return;
      }

      if (systemThemeChanged()) {
        isDark = !isDark;
        if (isDark) {
          setDarkTheme();
        } else {
          setLightTheme();
        }
        notifyListeners();
      }
    });
  }

  /// Vérifie si le thème système a changé.
  ///
  /// Compare le thème actuel du système avec le thème précédemment enregistré dans l'application.
  bool systemThemeChanged() {
    if (MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                    .platformBrightness ==
                Brightness.dark &&
            !isDark ||
        MediaQuery.of(NavigationService.navigatorKey.currentContext!)
                    .platformBrightness ==
                Brightness.light &&
            isDark) {
      return true;
    } else {
      return false;
    }
  }

  /// Définit le thème sombre de l'application.
  ///
  /// Configure les couleurs et les styles de texte pour correspondre au thème sombre.
  setDarkTheme() {
    bgColor = darkBgColor;
    text = textstyle.copyWith(color: Colors.white70);
    title = titlestyle.copyWith(color: Colors.white70);
    invertedColor = lightBgColor;
    primaryColor = primaryColorDark;
  }

  /// Définit le thème clair de l'application.
  ///
  /// Configure les couleurs et les styles de texte pour correspondre au thème clair.
  setLightTheme() {
    bgColor = lightBgColor;
    text = textstyle.copyWith(color: Colors.black87);
    title = titlestyle.copyWith(color: Colors.black87);
    invertedColor = darkBgColor;
    primaryColor = primaryColorLight;
  }
}
