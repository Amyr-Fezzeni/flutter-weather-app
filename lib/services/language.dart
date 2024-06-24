// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:weather_app/constants/language.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/local_data.dart';
import 'navigation_service.dart';

/// Renvoie la chaîne traduite pour une clé donnée en fonction de la langue actuelle de l'application.
String txt(String key) {
  // Récupère la langue actuelle de l'application.
  LanguageModel language = LocalData.getAppLanguage();
  // Renvoie la chaîne traduite pour la clé si disponible; sinon, renvoie la clé elle-même.
  return languageData[key]?[language.name] ?? key;
}

/// Un widget qui affiche du texte avec diverses options de style et support de traduction.
Widget Txt(
  String text, {
  Color? color,            // Couleur optionnelle pour le texte.
  double? size,            // Taille de police optionnelle pour le texte.
  bool center = false,     // Indicateur optionnel pour centrer le texte.
  TextStyle? style,        // Style de texte personnalisé optionnel.
  String extra = '',       // Texte supplémentaire optionnel à ajouter.
  int? maxLines,           // Nombre maximal de lignes optionnel pour le texte.
  bool translate = true,   // Indicateur optionnel pour activer/désactiver la traduction.
  bool bold = false,       // Indicateur optionnel pour rendre le texte en gras.
}) {
  return Text(
    // Traduire le texte si le drapeau translate est vrai, et ajouter le texte supplémentaire.
    (translate ? txt(text) : text) + extra,
    // Utiliser le style fourni ou créer un nouveau style avec la couleur, la taille et l'option de gras spécifiées.
    style: style ??
        NavigationService.navigatorKey.currentContext!.text.copyWith(
            color: color,
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : null),
    // Définir le nombre maximal de lignes et le comportement de débordement si maxLines est spécifié.
    maxLines: maxLines,
    overflow: maxLines != null ? TextOverflow.ellipsis : null,
    // Centrer le texte si le drapeau center est vrai.
    textAlign: center ? TextAlign.center : null,
  );
}