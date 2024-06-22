import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/icons_data.dart';
import 'package:weather_app/models/weather%20model/main_weather.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/blury_card.dart';

class PressureWidget extends StatelessWidget {
  final MainWeather main;
  const PressureWidget({super.key, required this.main});

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
            Txt("Pressure", color: Colors.white60, bold: true, size: 14.sp),
            Txt(getPressure(main), color: Colors.white60, bold: true),
            const Spacer(
              flex: 2,
            ),
            Center(
                child: Image.asset(humidity, height: 80, fit: BoxFit.contain)),
            const Spacer(),
          ],
        ),
      )),
    );
  }
}
