import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/theme.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/services/language.dart';

Future<void> customPopup(BuildContext context, Widget widget,
    {bool maxWidth = true}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: context.bgcolor,
          surfaceTintColor: context.bgcolor,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: defaultSmallRadius),
          child:
              SizedBox(width: maxWidth ? double.infinity : null, child: widget),
        );
      });
}

Widget settingsPopup(
    {required String title,
    required UnitModel selectedValue,
    Function(UnitModel)? onTap,
    List<UnitModel> lst = const []}) {
  return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(title, bold: true),
          PopupMenuButton<UnitModel>(
            initialValue: selectedValue,
            onSelected: (UnitModel item) {},
            surfaceTintColor: context.bgcolor,
            color: context.bgcolor,
            padding: const EdgeInsets.only(left: 200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Txt(selectedValue.name, color: context.iconColor, size: 18),
                Column(
                  children: [
                    SizedBox(
                      height: 15,
                      child: Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: context.iconColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: context.iconColor,
                        size: 20,
                      ),
                    )
                  ],
                )
              ],
            ),
            itemBuilder: (BuildContext context) => lst
                .map((e) => PopupMenuItem<UnitModel>(
                      value: e,
                      padding: const EdgeInsets.all(0),
                      onTap: () {
                        if (onTap != null) {
                          onTap(e);
                        }
                      },
                      child: Container(
                        color: context.appThemeRead.bgColor,
                        child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: e.name == selectedValue.name
                                    ? context.appThemeRead.primaryColor
                                        .withOpacity(.1)
                                    : null),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    e.name,
                                    style: context.appThemeRead.text.copyWith(
                                        color: e.name == selectedValue.name
                                            ? context.appThemeRead.primaryColor
                                            : null),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  });
}

Widget darkModePopup() {
  return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt('Dark mode', bold: true),
          PopupMenuButton<AppThemeModel>(
            initialValue: context.appThemeWatch.appTheme,
            onSelected: (AppThemeModel item) {},
            surfaceTintColor: context.bgcolor,
            color: context.bgcolor,
            padding: const EdgeInsets.only(left: 200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Txt(context.appThemeWatch.appTheme.name,
                    color: context.iconColor, size: 18),
                Column(
                  children: [
                    SizedBox(
                        height: 15,
                        child: Icon(Icons.keyboard_arrow_up_rounded,
                            color: context.iconColor, size: 20)),
                    SizedBox(
                        height: 15,
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            color: context.iconColor, size: 20))
                  ],
                )
              ],
            ),
            itemBuilder: (BuildContext context) => [
              AppThemeModel.dark,
              AppThemeModel.light,
              AppThemeModel.system
            ]
                .map((e) => PopupMenuItem<AppThemeModel>(
                      value: e,
                      padding: const EdgeInsets.all(0),
                      onTap: () => context.appThemeRead.changeDarkMode(e),
                      child: Container(
                        color: context.appThemeRead.bgColor,
                        child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    e.name == context.appThemeRead.appTheme.name
                                        ? context.appThemeRead.primaryColor
                                            .withOpacity(.1)
                                        : null),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    e.name,
                                    style: context.appThemeRead.text.copyWith(
                                        color: e.name ==
                                                context
                                                    .appThemeRead.appTheme.name
                                            ? context.appThemeRead.primaryColor
                                            : null),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  });
}


Widget languagePopup() {
  return Builder(builder: (context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt('Language', bold: true),
          PopupMenuButton<LanguageModel>(
            initialValue: context.dataWatch.currentLanguage,
            onSelected: (LanguageModel item) {},
            surfaceTintColor: context.bgcolor,
            color: context.bgcolor,
            padding: const EdgeInsets.only(left: 200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Txt(context.dataWatch.currentLanguage.name,
                    color: context.iconColor, size: 18),
                Column(
                  children: [
                    SizedBox(
                        height: 15,
                        child: Icon(Icons.keyboard_arrow_up_rounded,
                            color: context.iconColor, size: 20)),
                    SizedBox(
                        height: 15,
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            color: context.iconColor, size: 20))
                  ],
                )
              ],
            ),
            itemBuilder: (BuildContext context) => [
              LanguageModel.french,
              LanguageModel.english
            ]
                .map((e) => PopupMenuItem<LanguageModel>(
                      value: e,
                      padding: const EdgeInsets.all(0),
                      onTap: () => context.dataRead.changeDefaultLanguage(e),
                      child: Container(
                        color: context.appThemeRead.bgColor,
                        child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    e.name == context.dataRead.currentLanguage.name
                                        ? context.appThemeRead.primaryColor
                                            .withOpacity(.1)
                                        : null),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    e.name,
                                    style: context.appThemeRead.text.copyWith(
                                        color: e.name ==
                                                context
                                                    .dataRead.currentLanguage.name
                                            ? context.appThemeRead.primaryColor
                                            : null),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  });
}
