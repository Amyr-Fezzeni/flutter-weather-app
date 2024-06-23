import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:weather_app/constants/animation_data.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/weather%20model/weather_model.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
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
          image: DecorationImage(
              image: AssetImage(weatherBackgroung(
                  widget.weatherData.list.first.weather.first.main,
                  isDay(widget.weatherData.city))),
              fit: BoxFit.cover)),
      child: Builder(builder: (context) {
        bool isRaining =
            widget.weatherData.list.first.weather.first.main == "Rain";
        bool isSnow =
            widget.weatherData.list.first.weather.first.main == "Snow";
        return Stack(
          children: [
            if (isSnow)
              SizedBox(
                width: context.w,
                height: context.h,
                child: Lottie.asset(
                  snowAnimation,
                  repeat: true,
                  frameRate: const FrameRate(60),
                  fit: BoxFit.cover,
                ),
              ),
            if (isRaining)
              ParallaxRain(
                dropColors: const [Colors.grey],
                key: context.dataWatch.keys[context.dataWatch.currentCityIndex],
                trail: true,
                dropWidth: .4,
                numberOfDrops: 200,
                dropFallSpeed: 6,
              ),
            SafeArea(
                child: CurrentWeatherWidget(weatherData: widget.weatherData)),
            SafeArea(
              bottom: false,
              child: DraggableScrollableSheet(
                  initialChildSize: .6,
                  builder: (context, scroll) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration:
                            BoxDecoration(borderRadius: defaultBigRadius),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: scroll,
                          child: Column(
                            children: [
                              if (context.dataWatch.mainCity != null &&
                                  context.dataWatch.currentCityIndex != 0)
                                BluryCard(
                                    width: null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.access_time_rounded,
                                              color: Colors.white70, size: 15),
                                          const Gap(5),
                                          Txt(
                                              getTimeZoneCityString(
                                                  widget.weatherData.city),
                                              translate: false,
                                              color: Colors.white70,
                                              size: 14.sp),
                                        ],
                                      ),
                                    )),
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
                                      weatherList:
                                          widget.weatherData.list.first),
                                ],
                              ),
                              const Gap(20)
                            ],
                          ),
                        ),
                      )),
            ),
          ],
        );
      }),
    );
  }
}
