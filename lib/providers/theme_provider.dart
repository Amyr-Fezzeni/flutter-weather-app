import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/theme.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:weather_app/services/local_data.dart';

class AppThemeProvider with ChangeNotifier {
  AppThemeModel appTheme = AppThemeModel.system;
  Color bgColor = lightBgColor;
  TextStyle text = textstyle;
  TextStyle title = titlestyle;
  bool isDark = false;
  Color invertedColor = darkBgColor;
  Color primaryColor = primaryColorLight;

  bool getSystemTheme() {
    final brightness =
        MediaQuery.of(NavigationService.navigatorKey.currentContext!)
            .platformBrightness;
    return brightness == Brightness.dark;
  }

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
  }

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

  startThemeListen() {
    if (appTheme != AppThemeModel.system) return;
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (appTheme != AppThemeModel.system) timer.cancel();

      if (systemThemeChanged()) {
        isDark = !isDark;
        if (isDark) {
          setDarkTheme();
        } else {
          setLightTheme();
        }
        log('Dark mode changed');
        notifyListeners();
      }
    });
  }

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

  setDarkTheme() {
    bgColor = darkBgColor;
    text = textstyle.copyWith(color: Colors.white70);
    title = titlestyle.copyWith(color: Colors.white70);
    invertedColor = lightBgColor;
    primaryColor = primaryColorDark;
  }

  setLightTheme() {
    bgColor = lightBgColor;
    text = textstyle.copyWith(color: Colors.black87);
    title = titlestyle.copyWith(color: Colors.black87);
    invertedColor = darkBgColor;
    primaryColor = primaryColorLight;
  }
}
