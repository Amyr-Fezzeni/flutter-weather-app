import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/icons_data.dart';
import 'package:weather_app/models/weather%20model/wind.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/widgets/blury_card.dart';
import 'package:weather_app/services/weather_services.dart';

class WindWidget extends StatelessWidget {
  final Wind wind;
  const WindWidget({super.key, required this.wind});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BluryCard(
          child: Container(
        padding: const EdgeInsets.all(10),
        height: 160.sp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Txt("Wind", color: Colors.white60, bold: true, size: 14.sp),
            Txt(getWindSpeed(wind.speed),
                color: Colors.white60,
                bold: true,
                translate: false,
                size: 14.sp),
            const Spacer(flex: 2),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                  height: 85.sp,
                  width: 85.sp,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white12, width: 2),
                      borderRadius: BorderRadius.circular(100),
                      image: const DecorationImage(
                          image: AssetImage(compassBackground),
                          fit: BoxFit.contain)),
                  child: SizedBox(
                    child: Center(
                      child: Transform.rotate(
                          angle: wind.deg * pi / 180,
                          child: Image.asset(compas,
                              height: 60.sp, fit: BoxFit.contain)),
                    ),
                  )),
            ),
            const Spacer(),
          ],
        ),
      )),
    );
  }
}
