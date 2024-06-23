import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/icons_data.dart';
import 'package:weather_app/models/weather%20model/city.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/blury_card.dart';

class SunTimeWidget extends StatelessWidget {
  final City city;
  const SunTimeWidget({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BluryCard(
          child: Container(
        padding: const EdgeInsets.all(10),
        height: 160.sp,
        child: Builder(builder: (context) {
          final data = getSunsetSunriseTime(city);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(data['title'] as String,
                  color: Colors.white60, bold: true, size: 14.sp),
              Txt(data['date'] as String, color: Colors.white60, bold: true),
              const Spacer(
                flex: 2,
              ),
              Center(
                  child: Image.asset(
                      data['title'] == "Sunset" ? sunset : sunrise,
                      height: 80,
                      fit: BoxFit.contain)),
              const Spacer(),
            ],
          );
        }),
      )),
    );
  }
}
