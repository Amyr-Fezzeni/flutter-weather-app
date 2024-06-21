import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/views/city/add_city.dart';
import 'package:weather_app/widgets/appbar.dart';
import 'package:weather_app/widgets/weather/city_card.dart';

class ManageCities extends StatefulWidget {
  const ManageCities({super.key});

  @override
  State<ManageCities> createState() => _ManageCitiesState();
}

class _ManageCitiesState extends State<ManageCities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Manage cities'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    color: context.invertedColor.withOpacity(.05),
                    borderRadius: defaultBigRadius),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () => context.showPopUpScreen(const AddCity()),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, color: context.iconColor),
                      const Gap(10),
                      Txt('Enter Location',
                          color: context.invertedColor.withOpacity(0.4),
                          size: 14)
                    ],
                  ),
                ),
              ),
              const Gap(20),
              ...context.dataWatch.cityList.map((e) => CityCard(city: e))
            ],
          ),
        ),
      ),
    );
  }
}
