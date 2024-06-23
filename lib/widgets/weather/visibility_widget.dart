import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/icons_data.dart';
import 'package:weather_app/models/weather%20model/weather_list.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/blury_card.dart';

class VisibilityWidget extends StatelessWidget {
  final WeatherList weatherList;
  const VisibilityWidget({super.key, required this.weatherList});

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
            Txt("Visibility", color: Colors.white60, bold: true, size: 14.sp),
            Txt(getVisibility(weatherList), color: Colors.white60, bold: true,translate: false),
            const Spacer(
              flex: 2,
            ),
            Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 10),
                child: Image.asset(visibility,
                    height: 80.sp, fit: BoxFit.contain)),
            const Spacer(),
          ],
        ),
      )),
    );
  }
}
