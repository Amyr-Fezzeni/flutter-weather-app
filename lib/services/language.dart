// ignore_for_file: non_constant_identifier_names


import 'package:flutter/material.dart';
import 'package:weather_app/constants/language.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/local_data.dart';
import 'navigation_service.dart';


String txt(String key) {
  LanguageModel language = LocalData.getAppLanguage();
  return languageData[key]?[language.name] ?? "$key***";
}


Widget Txt(String text,
    {Color? color,
    double? size,
    bool center = false,
    TextStyle? style,
    String extra = '',
    int? maxLines,
    bool translate = true,
    bool bold = false}) {
  return Text(
    (translate ? txt(text) : text) + extra,
    style: style ??
        NavigationService.navigatorKey.currentContext!.text.copyWith(
            color: color,
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : null),
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    textAlign: center ? TextAlign.center : null,
  );
}
