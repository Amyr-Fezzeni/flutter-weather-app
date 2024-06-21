import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/widgets/blury_card.dart';

class WeatherDetails extends StatefulWidget {
  final WeatherModel weatherData;
  const WeatherDetails({super.key, required this.weatherData});

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  late final List<Map<String, dynamic>> _data;
  @override
  void initState() {
    _data = getDailyMaxMinTemperatures(widget.weatherData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w,
      decoration: BoxDecoration(
        color: context.primaryColor,
        // gradient: getGradient(widget.weatherData.list.first.weather.first.main),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(widget.weatherData.city.name,
                      bold: true, size: 18, color: Colors.white),
                  Txt(
                      calculateTemperature(
                          widget.weatherData.list.first.main.temp),
                      style: context.title.copyWith(
                          color: Colors.white.withOpacity(.9),
                          fontSize: context.w * .25)),
                  Txt('${capitalize(widget.weatherData.list.first.weather.first.description)}  ${calculateTemperature(_data.first['max'])} / ${calculateTemperature(_data.first['min'])}',
                      translate: false, color: Colors.white),
                  MaterialButton(
                    onPressed: () {
                      final data =
                          getDailyMaxMinTemperatures(widget.weatherData);
                      log(getDayIcon(data.first['icons']));
                    },
                    child: Txt('text'),
                  )
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
              initialChildSize: .4,
              builder: (context, scroll) => Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: defaultBigRadius),
                    child: SingleChildScrollView(
                      controller: scroll,
                      child: const Column(
                        children: [
                          BluryCard(child: SizedBox(height: 300)),
                          BluryCard(child: SizedBox(height: 200)),
                          Row(
                            children: [
                              Flexible(
                                child: BluryCard(child: SizedBox(height: 200)),
                              ),
                              Flexible(
                                child: BluryCard(child: SizedBox(height: 200)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: BluryCard(child: SizedBox(height: 200)),
                              ),
                              Flexible(
                                child: BluryCard(child: SizedBox(height: 200)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: BluryCard(child: SizedBox(height: 200)),
                              ),
                              Flexible(
                                child: BluryCard(child: SizedBox(height: 200)),
                              ),
                            ],
                          ),
                          BluryCard(child: SizedBox(height: 100)),
                          Gap(20)
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
