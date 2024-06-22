import 'package:flutter/material.dart';
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
        initialChildSize: .95,
        maxChildSize: .95,
        minChildSize: .5,
        builder: (context, scrollController) => SafeArea(
              child: Container(
                color: context.bgcolor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const Gap(40),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: TextFormField(
                                autofocus: true,
                                onFieldSubmitted: (val) {
                                  focus.unfocus();
                                },
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
                                      fontSize: 14),
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
                              child: Txt('Cancel',
                                  color: context.primaryColor, bold: true)),
                        ],
                      ),
                      const Gap(20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (locationsData.isEmpty && firstSearch) ...[
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: context.iconColor,
                                  size: 35,
                                ),
                                Txt('No results.')
                              ],
                              ...locationsData
                                  .map((e) => Builder(builder: (context) {
                                        bool added = context.dataWatch.cityList
                                            .where((city) =>
                                                "${city.city.coord.lat}${city.city.coord.lon}" ==
                                                "${e.lat}${e.lon}")
                                            .isNotEmpty;
                                        return ListTile(
                                          onTap: () => added
                                              ? null
                                              : context.dataRead.addCity(e),
                                          title: Txt(e.name ?? '',
                                              translate: false, bold: true),
                                          subtitle: Txt(
                                              [e.country, e.state].join(', '),
                                              translate: false),
                                          trailing: added
                                              ? Txt("Added", bold: true)
                                              : const Icon(Icons.add),
                                        );
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
