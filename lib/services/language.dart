// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:weather_app/services/context_extention.dart';
import 'navigation_service.dart';

// enum LanguageModel { french, english }

String txt(String key) {
  // log(DataPrefrences.getAccountType());
  // return key;
  // LanguageModel language = NavigationService.navigatorKey.currentContext!
  //     .dataRead
  //     .currentLanguage;
  // addKey(key);
  return key;
  // return language == LanguageModel.english
  //     ? english[key] ?? key
  //     : frensh[key] ?? key;
}

// void addKey(String key) {
//   File file = File('/Users/letaff/flutter projects/flutter_weather_app/assets/language.json');
//   Map<String, dynamic> data =
//       jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
//   if (!data.containsKey(key)) {
//     data.addAll({key: key});
//     file.writeAsStringSync(jsonEncode(data));
//     log('$key saved');
//   }
// }

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

