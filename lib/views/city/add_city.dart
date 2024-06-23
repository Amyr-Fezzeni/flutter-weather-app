import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';

class AddCity extends StatefulWidget {
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCityState();
}

class _AddCityState extends State<AddCity> {
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  List<CityInfo> locationsData = [];
  bool firstSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 1,
        maxChildSize: 1,
        minChildSize: .5,
        builder: (context, scrollController) => Container(
              color: context.bgcolor,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.sp),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextFormField(
                                  autofocus: true,
                                  onFieldSubmitted: (val) => focus.unfocus(),
                                  onChanged: (value) {
                                    if (value.toString().trim().length < 2) {
                                      return;
                                    }

                                    context.dataRead
                                        .getListCities(controller.text.trim())
                                        .then((value) => setState(() {
                                              locationsData = value;
                                              firstSearch = true;
                                            }));
                                  },
                                  controller: controller,
                                  autocorrect: true,
                                  style: context.text,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        context.invertedColor.withOpacity(0.05),
                                    hintText: txt("Enter Location"),
                                    suffixIcon: controller.text.isEmpty
                                        ? null
                                        : InkWell(
                                            onTap: () => setState(
                                                () => controller.clear()),
                                            child: Icon(Icons.close,
                                                color: context.iconColor),
                                          ),
                                    prefixIcon: Container(
                                        width: 30,
                                        height: 30,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Icon(Icons.search_rounded,
                                            color: context.iconColor)),
                                    hintStyle: context.text.copyWith(
                                        color: context.invertedColor
                                            .withOpacity(0.4),
                                        fontSize: 14.sp),
                                    contentPadding:
                                        const EdgeInsets.only(left: 15),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: defaultBigRadius,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(15),
                            InkWell(
                                onTap: () => Navigator.pop(context),
                                child:
                                    Txt('Cancel', color: context.primaryColor)),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (locationsData.isEmpty && firstSearch) ...[
                                Icon(Icons.info_outline_rounded,
                                    color: context.iconColor, size: 35.sp),
                                Txt('No results.')
                              ],
                              ...locationsData
                                  .map((city) => Builder(builder: (context) {
                                        return ListTile(
                                            onTap: () =>
                                                context.dataRead.addCity(city),
                                            title: Txt(city.name ?? '',
                                                translate: false, bold: true),
                                            subtitle: Txt(
                                                [
                                                  city.name,
                                                  city.state,
                                                  city.country
                                                ]
                                                    .where((e) => e != null)
                                                    .join(', '),
                                                translate: false,
                                                color: context.iconColor,
                                                size: 14.sp),
                                            trailing: Icon(Icons.add,
                                                color: context.iconColor,
                                                size: 20));
                                      }))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
