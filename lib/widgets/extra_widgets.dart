import 'package:flutter/material.dart';
import 'package:weather_app/services/context_extention.dart';

Widget cLoader({double size = 50}) {
  return SizedBox(
    height: size,
    width: size,
    child: const Center(child: CircularProgressIndicator()),
  );
}

Widget divider({double bottom = 0, double top = 0}) =>
    Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(top: top, bottom: bottom),
        child: Divider(
          height: 5,
          color: context.invertedColor.withOpacity(.1),
        ),
      );
    });
