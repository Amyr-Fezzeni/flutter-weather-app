import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// App text Style
TextStyle textstyle = GoogleFonts.nunito(color: Colors.black87, fontSize: 14);

TextStyle titlestyle = GoogleFonts.poppins(
    color: Colors.white, fontSize: 35, fontWeight: FontWeight.w800);

// App colors
const lightBgColor = Color.fromARGB(255, 255, 255, 255);
const darkBgColor = Color.fromARGB(255, 23, 23, 23);

const primaryColorLight = Color(0xff90B2F9);
const primaryColorDark = Color(0xff90B2F8);

const primaryGradient = [
  Color.fromARGB(255, 82, 113, 255),
  Color.fromARGB(255, 91, 121, 251)
];

const palette = [
  Color.fromRGBO(75, 135, 185, 1),
  Color.fromRGBO(246, 114, 128, 1),
  Color.fromRGBO(248, 177, 149, 1),
  Color.fromRGBO(116, 180, 155, 1),
  Color.fromRGBO(0, 168, 181, 1),
  Color.fromRGBO(73, 76, 162, 1),
  Color.fromRGBO(255, 205, 96, 1),
  Color.fromRGBO(255, 240, 219, 1),
  Color.fromRGBO(238, 238, 238, 1)
];

// Extra settings
const double smallRadius = 8;
const double bigRadius = 20;
final defaultSmallRadius = BorderRadius.circular(smallRadius);
final defaultBigRadius = BorderRadius.circular(bigRadius);
