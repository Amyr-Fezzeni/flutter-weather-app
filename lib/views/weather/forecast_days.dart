import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/appbar.dart';
import 'package:weather_app/widgets/extra_widgets.dart';

class Forecast4DaysScreen extends StatelessWidget {
  final List<Map<String, dynamic>> forecastData;
  const Forecast4DaysScreen({super.key, required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('5-day forecast'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10)
              .copyWith(top: 20, bottom: 50),
          child: Column(
            children: [for (var data in forecastData) dayWidget(data)],
          ),
        ),
      ),
    );
  }

  Widget dayWidget(Map<String, dynamic> data) => Builder(builder: (context) {
        bool isToday = data['dayName'] == "Today";
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: isToday ? context.invertedColor.withOpacity(.1) : null,
                  borderRadius: defaultSmallRadius),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(data['dayName'],
                          extra: ' - ${data['date']}', bold: true),
                      const Gap(5),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Txt("Wind", extra: ': ', size: 14.sp),
                          Transform.rotate(
                              angle: data['wind']['deg'] * pi / 180,
                              child: Icon(Icons.arrow_upward_rounded,
                                  size: 15, color: context.iconColor)),
                          Flexible(
                              child: Txt(getWindSpeed(data['wind']['speed']),
                                  size: 14.sp, translate: false)),
                        ],
                      ),
                      Txt("Humidity",
                          extra: ': ${data['humidity']}%', size: 14.sp),
                      Txt("Pressure",
                          extra: ': ${getPressure(data['pressure'])}',
                          size: 14.sp),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Image.asset(getAssetIcon(data['maxIcon']),
                              height: 30.sp, width: 30.sp),
                          const Gap(20),
                          SizedBox(
                            // width: 50,
                            child: Center(
                              child: Txt(getTemperature(data['max']),
                                  translate: false, size: 18.sp),
                            ),
                          ),
                        ].reversed.toList(),
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          Image.asset(getAssetIcon(data['minIcon']),
                              height: 30.sp, width: 30.sp),
                          const Gap(20),
                          SizedBox(
                            // width: 50,
                            child: Center(
                              child: Txt(getTemperature(data['min']),
                                  translate: false,
                                  color: context.iconColor,
                                  size: 18.sp),
                            ),
                          ),
                        ].reversed.toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            divider(bottom: 5, top: 5)
          ],
        );
      });
  Widget oldWidget() => Builder(builder: (context) {
        final lineBarsDataMax = [
          LineChartBarData(
            spots: [
              ...List.generate(
                  forecastData.length,
                  (index) => FlSpot(
                      index.toDouble(),
                      double.parse(getTemperature(forecastData[index]['max'])
                          .split('°')
                          .first))),
            ],
            isCurved: false,
            color: context.invertedColor.withOpacity(.4),
            barWidth: 2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                  color: context.appThemeRead.invertedColor.withOpacity(.7)),
            ),
          ),
        ];
        final tooltipsOnBarMax = lineBarsDataMax[0];

        final lineBarsDataMin = [
          LineChartBarData(
            spots: List.generate(
                forecastData.length,
                (index) => FlSpot(
                    index.toDouble(),
                    double.parse(getTemperature(forecastData[index]['min'])
                        .split('°')
                        .first))),
            isCurved: false,
            color: context.invertedColor.withOpacity(.4),
            barWidth: 2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                  color: context.appThemeRead.invertedColor.withOpacity(.7)),
            ),
          ),
        ];
        final tooltipsOnBarMin = lineBarsDataMin[0];
        return Stack(
          children: [
            Row(
              children: [
                for (var data in forecastData)
                  Builder(builder: (context) {
                    bool isToday = data['dayName'] == "Today";
                    return Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                            color: isToday
                                ? context.invertedColor.withOpacity(.1)
                                : null,
                            borderRadius: defaultSmallRadius),
                        child: Column(
                          children: [
                            Txt(data['dayName'], size: 14.sp),
                            Txt(data['date'], size: 14.sp, translate: false),
                            const Gap(10),
                            Image.asset(getAssetIcon(data['maxIcon']),
                                height: 30.sp, width: 30.sp),
                            const Gap(200),
                            Image.asset(getAssetIcon(data['minIcon']),
                                height: 30.sp, width: 30.sp),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.rotate(
                                  angle: data['wind']['deg'] * pi / 180,
                                  child: Icon(Icons.arrow_upward_rounded,
                                      size: 15, color: context.iconColor),
                                ),
                                Flexible(
                                  child: Txt(
                                      getWindSpeed(data['wind']['speed']),
                                      size: 14.sp,
                                      translate: false),
                                ),
                              ],
                            ),
                            const Gap(5),
                          ],
                        ),
                      ),
                    );
                  })
              ],
            ),
            const Gap(20),
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Center(
                child: SizedBox(
                  height: 80,
                  width: context.w - 120,
                  child: LineChart(LineChartData(
                    gridData: const FlGridData(show: false),
                    maxY: 50,
                    lineTouchData: LineTouchData(
                        enabled: false,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchedSpot) => Colors.transparent,
                          getTooltipItems: (touchedSpots) => touchedSpots
                              .map((e) => LineTooltipItem(
                                  '${e.y.toInt()}°', context.appThemeRead.text))
                              .toList(),
                        )),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    showingTooltipIndicators:
                        List.generate(tooltipsOnBarMin.spots.length, (index) {
                      return ShowingTooltipIndicators([
                        LineBarSpot(
                          tooltipsOnBarMax,
                          lineBarsDataMax.indexOf(tooltipsOnBarMax),
                          tooltipsOnBarMax.spots[index],
                        ),
                      ]);
                    }),
                    lineBarsData: lineBarsDataMax,
                  )),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Center(
                child: SizedBox(
                  height: 80,
                  width: context.w - 120,
                  child: LineChart(LineChartData(
                    gridData: const FlGridData(show: false),
                    maxY: 50,
                    lineTouchData: LineTouchData(
                        enabled: false,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchedSpot) => Colors.transparent,
                          getTooltipItems: (touchedSpots) => touchedSpots
                              .map((e) => LineTooltipItem(
                                  '${e.y.toInt()}°', context.appThemeRead.text))
                              .toList(),
                        )),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    showingTooltipIndicators:
                        List.generate(tooltipsOnBarMin.spots.length, (index) {
                      return ShowingTooltipIndicators([
                        LineBarSpot(
                          tooltipsOnBarMin,
                          lineBarsDataMin.indexOf(tooltipsOnBarMin),
                          tooltipsOnBarMin.spots[index],
                        ),
                      ]);
                    }),
                    lineBarsData: lineBarsDataMin,
                  )),
                ),
              ),
            ),
          ],
        );
      });
}
