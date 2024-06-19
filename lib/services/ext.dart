import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';

extension ContextExt on BuildContext {
  double get h => MediaQuery.of(this).size.height;
  double get w => MediaQuery.of(this).size.width;

  AppThemeProvider get appThemeWatch => watch<AppThemeProvider>();
  AppThemeProvider get appthemeRead => read<AppThemeProvider>();
  
  DataProvider get dataWatch => watch<DataProvider>();
  DataProvider get dataRead => read<DataProvider>();

  // App Style
  TextStyle get text => appThemeWatch.text;
  TextStyle get title => appThemeWatch.title;
  Color get bgcolor => appThemeWatch.bgColor;
  Color get invertedColor => appThemeWatch.invertedColor;
  Color get iconColor => invertedColor.withOpacity(.7);
  Color get primaryColor => appThemeWatch.primaryColor;

  replaceWith(Widget screen) => Navigator.pushReplacement(
      this, MaterialPageRoute(builder: (context) => screen));

  moveToAndRemoveHistory(Widget screen) =>
      Navigator.of(this).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => screen),
          (Route<dynamic> route) => false);

  showPopUpScreen(Widget screen) => showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: this,
      builder: (context) => screen);
  pop() => Navigator.pop(this);
}
