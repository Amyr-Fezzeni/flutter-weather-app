// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weather_app/constants/language.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/local_data.dart';
import 'navigation_service.dart';

/// Returns the translated string for a given key based on the current app language.
String txt(String key) {
  // Retrieve the current language of the app.
  LanguageModel language = LocalData.getAppLanguage();
  // Return the translated string for the key if available; otherwise, return the key itself.
  return languageData[key]?[language.name] ?? key;
}

/// A widget that displays text with various style options and translation support.
Widget Txt(
  String text, {
  Color? color,            // Optional color for the text.
  double? size,            // Optional font size for the text.
  bool center = false,     // Optional flag to center the text.
  TextStyle? style,        // Optional custom text style.
  String extra = '',       // Optional extra text to append.
  int? maxLines,           // Optional maximum number of lines for the text.
  bool translate = true,   // Optional flag to enable/disable translation.
  bool bold = false,       // Optional flag to make the text bold.
}) {
  return Text(
    // Translate the text if the translate flag is true, and append the extra text.
    (translate ? txt(text) : text) + extra,
    // Use the provided style or create a new style with the given color, size, and bold option.
    style: style ??
        NavigationService.navigatorKey.currentContext!.text.copyWith(
            color: color,
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : null),
    // Set the maximum number of lines and the overflow behavior if maxLines is specified.
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    // Center the text if the center flag is true.
    textAlign: center ? TextAlign.center : null,
  );
}