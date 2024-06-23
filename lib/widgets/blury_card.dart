import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_style.dart';

class BluryCard extends StatelessWidget {
  final Widget child;
  final double? width;
  const BluryCard({super.key, required this.child, this.width = double.maxFinite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            width: width,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.2),
                borderRadius: defaultBigRadius),
            child: child,
          ),
        ),
      ),
    );
  }
}
