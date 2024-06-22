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

class Forecast4DaysScreen extends StatelessWidget {
  final List<Map<String, dynamic>> forecastData;
  const Forecast4DaysScreen({super.key, required this.forecastData});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: appBar('4-day forecast'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Stack(
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
                              Txt(data['date'], size: 14.sp),
                              const Gap(10),
                              Image.network(getIconUrl(data['maxIcon']),
                                  height: 40, width: 40),
                              const Gap(200),
                              Image.network(getIconUrl(data['minIcon']),
                                  height: 40, width: 40),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Transform.rotate(
                                    angle: data['wind']['deg'] * pi / 180,
                                    child: Icon(Icons.arrow_upward_rounded,
                                        size: 15, color: context.iconColor),
                                  ),
                                  Txt(getWindSpeed(data['wind']['speed']),
                                      size: 14.sp),
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
                            getTooltipColor: (touchedSpot) =>
                                Colors.transparent,
                            getTooltipItems: (touchedSpots) => touchedSpots
                                .map((e) => LineTooltipItem('${e.y.toInt()}°',
                                    context.appThemeRead.text))
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
                            getTooltipColor: (touchedSpot) =>
                                Colors.transparent,
                            getTooltipItems: (touchedSpots) => touchedSpots
                                .map((e) => LineTooltipItem('${e.y.toInt()}°',
                                    context.appThemeRead.text))
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
          ),
        ),
      ),
    );
  }
}
