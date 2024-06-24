import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/views/city/manage_cities.dart';
import 'package:weather_app/views/weather/weather_details.dart';
import 'package:weather_app/views/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..forward();
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.linear);

  @override
  void initState() {
    context.appThemeRead.initTheme();
    context.dataRead.initData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.primaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => context.moveTo(const ManageCities()),
            icon: Icon(Icons.add, color: Colors.white, size: 25.sp),
            tooltip: txt('Add city'),
          ),
          IconButton(
            onPressed: () => context.moveTo(const Settings()),
            icon:
                Icon(Icons.more_vert_rounded, color: Colors.white, size: 25.sp),
            tooltip: txt('Settings'),
          )
        ],
      ),
      body: SizedBox(
        height: context.h,
        width: context.w,
        child: Builder(
          builder: (context) => (context.dataWatch.cityList.isNotEmpty ||
                  context.dataWatch.mainCity != null)
              ? GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (details.primaryVelocity! > 0) {
                      context.dataRead.updateCurrentCityIndex(true);
                      _controller.reset();
                      _controller.forward();
                    } else if (details.primaryVelocity! < 0) {
                      context.dataRead.updateCurrentCityIndex(false);
                      _controller.reset();
                      _controller.forward();
                    }
                  },
                  child: FadeTransition(
                      opacity: _animation,
                      child: WeatherDetails(
                          weatherData: context.dataWatch.allCityList[
                              context.dataWatch.currentCityIndex])),
                )
              : Center(
                  child: ElevatedButton(
                  onPressed: () => context.moveTo(const ManageCities()),
                  child:
                      Txt('Add city', color: context.primaryColor, bold: true),
                )),
        ),
      ),
    );
  }
}
