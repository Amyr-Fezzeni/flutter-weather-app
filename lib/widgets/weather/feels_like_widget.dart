import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/icons_data.dart';
import 'package:weather_app/models/weather%20model/main_weather.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/blury_card.dart';

class FeelsLikeWidget extends StatelessWidget {
  final MainWeather main;
  const FeelsLikeWidget({super.key, required this.main});

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
            Txt("Real feel", color: Colors.white60, bold: true, size: 14.sp),
            Txt(getRealFeel(main), color: Colors.white60, bold: true,translate: false,
                size: 14.sp),
            const Spacer(
              flex: 2,
            ),
            Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 20),
                child:
                    Image.asset(realfeel, height: 80.sp, fit: BoxFit.contain)),
            const Spacer(),
          ],
        ),
      )),
    );
  }
}
