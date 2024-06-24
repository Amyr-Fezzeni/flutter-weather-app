import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/services/context_extention.dart';
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
      appBar: appBar('Manage cities',
          leadingWidget: context.manageCitiesWatch.manageCities
              ? InkWell(
                  onTap: () =>
                      context.manageCitiesRead.updateManageCities(false),
                  child: Icon(Icons.close_rounded,
                      color: context.iconColor, size: 25.sp))
              : null),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (context.manageCitiesWatch.manageCities)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Txt(context.manageCitiesRead.getTitle(),
                            bold: true, translate: false),
                      ),
                    Container(
                      width: double.maxFinite,
                      height: 50.sp,
                      decoration: BoxDecoration(
                          color: context.invertedColor.withOpacity(.05),
                          borderRadius: defaultBigRadius),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () => context.showPopUpScreen(const AddCity()),
                        child: Row(
                          children: [
                            Icon(Icons.search_rounded,
                                color: context.iconColor, size: 25.sp),
                            const Gap(10),
                            Txt('Enter Location',
                                color: context.invertedColor.withOpacity(0.4),
                                size: 14.sp)
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    if (context.dataWatch.mainCity != null)
                      CityCard(
                          key: ValueKey(context.dataWatch.mainCity!.city.id),
                          weatherData: context.dataWatch.mainCity!,
                          canBeDeleted: false,
                          index: 0),
                    SizedBox(
                      height: context.dataWatch.cityList.length * 110.sp,
                      child: ReorderableListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                              context.dataWatch.cityList.length,
                              (index) => CityCard(
                                    key: ValueKey(context
                                        .dataWatch.cityList[index].city.id),
                                    weatherData:
                                        context.dataWatch.cityList[index],
                                    index: index +
                                        (context.dataWatch.mainCity != null
                                            ? 1
                                            : 0),
                                  )),
                          onReorder: (oldIndex, newIndex) =>
                              context.dataRead.orderCities(oldIndex, newIndex)),
                    ),
                    const Gap(50)
                  ],
                ),
              ),
            ),
            if (context.manageCitiesWatch.manageCities)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10)
                    .copyWith(bottom: 10),
                child: Center(
                  child: InkWell(
                    onTap: context.manageCitiesRead.deleteSelectedCities,
                    child: Icon(Icons.delete_outline_rounded,
                        color: context.iconColor, size: 30.sp),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
