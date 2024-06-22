import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/blury_card.dart';
import 'package:weather_app/widgets/weather/hourly_temp_widget.dart';
import 'package:weather_app/widgets/weather/wind_widget.dart';

import '../../widgets/weather/current_weather_widget.dart';
import '../../widgets/weather/days_forecast_widget.dart';
import '../../widgets/weather/feels_like_widget.dart';
import '../../widgets/weather/humidity_widget.dart';
import '../../widgets/weather/pressure_widget.dart';
import '../../widgets/weather/sun_time_widget.dart';
import '../../widgets/weather/visibility_widget.dart';

class WeatherDetails extends StatefulWidget {
  final WeatherModel weatherData;
  const WeatherDetails({super.key, required this.weatherData});

  @override
  State<WeatherDetails> createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w,
      decoration: BoxDecoration(
          // color: context.primaryColor,
          image: DecorationImage(
              image: AssetImage(weatherBackgroung(
                  widget.weatherData.list.first.weather.first.main,
                  isDay(widget.weatherData.city))),
              fit: BoxFit.cover)),
      child: SafeArea(
        child: Stack(
          children: [
            CurrentWeatherWidget(weatherData: widget.weatherData),
            DraggableScrollableSheet(
                initialChildSize: .45,
                builder: (context, scroll) => Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: defaultBigRadius),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: scroll,
                        child: Column(
                          children: [
                            DaysForecastWidget(
                                weatherList: widget.weatherData.list),
                            HourlyTemperatureWidget(
                                weatherList: widget.weatherData.list),
                            Row(
                              children: [
                                WindWidget(
                                    wind: widget.weatherData.list.first.wind),
                                HumidityWidget(
                                    main: widget.weatherData.list.first.main)
                              ],
                            ),
                            Row(
                              children: [
                                FeelsLikeWidget(
                                    main: widget.weatherData.list.first.main),
                                PressureWidget(
                                    main: widget.weatherData.list.first.main),
                              ],
                            ),
                            Row(
                              children: [
                                SunTimeWidget(city: widget.weatherData.city),
                                VisibilityWidget(
                                    weatherList: widget.weatherData.list.first),
                              ],
                            ),
                            const BluryCard(child: SizedBox(height: 100)),
                            const Gap(20)
                          ],
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
