import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/extra_widgets.dart';

class CityCard extends StatefulWidget {
  final WeatherModel weatherData;
  final bool canBeDeleted;
  final int index;
  const CityCard(
      {super.key,
      required this.weatherData,
      this.canBeDeleted = true,
      required this.index});

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  late final List<Map<String, dynamic>> _data;
  @override
  void initState() {
    _data = getDailyMaxMinTemperatures(widget.weatherData.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.sp,
      // width: context.w - 40,
      child: Stack(
        children: [
          Positioned(
            top: 30.sp,
            right: 0,
            left: 0,
            child: Container(
              height: 80.sp,
              width: context.w,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              // margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: context.bgcolor,
                  borderRadius: defaultSmallRadius,
                  boxShadow: defaultBoxShadow,
                  image: DecorationImage(
                      image: AssetImage(weatherBackgroungCard(
                          widget.weatherData.list.first.weather.first.main,
                          isDay(widget.weatherData.city))),
                      fit: BoxFit.cover)),
              child: InkWell(
                onLongPress: context.manageCitiesWatch.manageCities
                    ? null
                    : () => context.manageCitiesRead.updateManageCities(true),
                onTap: () {
                  if (context.manageCitiesRead.manageCities) {
                    context.manageCitiesRead
                        .addOrRemodeCity(widget.weatherData.city.id);
                    return;
                  }
                  context.dataRead.updateCurrentCityIndexByIndex(widget.index);
                  Future.delayed(const Duration(milliseconds: 10))
                      .then((value) => context.pop());
                },
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Txt(capitalize(widget.weatherData.city.name),
                                bold: true,
                                translate: false,
                                color: Colors.white,
                                size: 18.sp),
                            if (!widget.canBeDeleted)
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(Icons.near_me,
                                    color: Colors.white, size: 14),
                              )
                          ],
                        ),
                        Builder(builder: (context) {
                          String description = capitalize(widget.weatherData
                              .list.first.weather.first.description);
                          String maxTemp = getTemperature(_data.first['max']);
                          String minTemp = getTemperature(_data.first['min']);
                          return Txt('$description  $maxTemp / $minTemp',
                              translate: false,
                              color: Colors.white,
                              size: 14.sp);
                        }),
                      ],
                    ),
                    const Spacer(),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     // Image.asset(
                    //     //     getAssetIcon(widget
                    //     //         .weatherData.list.first.weather.first.icon),
                    //     //     height: 40,
                    //     //     width: 40),
                    //     Txt(
                    //         getTemperature(
                    //             widget.weatherData.list.first.main.temp),
                    //         color: Colors.white,
                    //         bold: true,
                    //         size: 20.sp),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Txt(
                          getTemperature(
                              widget.weatherData.list.first.main.temp),
                          color: Colors.white,
                          bold: true,
                          size: 20.sp),
                    ),
                    if (context.manageCitiesWatch.manageCities &&
                        widget.canBeDeleted)
                      checkBox(
                          value: context.manageCitiesWatch.selectedCities
                              .contains(widget.weatherData.city.id),
                          function: () => context.manageCitiesRead
                              .addOrRemodeCity(widget.weatherData.city.id))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 15.sp,
            top: 0,
            child: Image.asset(
                getAssetIcon(widget.weatherData.list.first.weather.first.icon),
                height: 55.sp,
                width: 55.sp),
          )
        ],
      ),
    );
  }
}
