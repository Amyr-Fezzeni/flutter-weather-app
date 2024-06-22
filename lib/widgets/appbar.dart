import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/models/theme.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';

AppBar appBar(String title,
    {leading = true,
    Widget action = const SizedBox(),
    bool leadingProfile = false}) {
  return AppBar(
    shadowColor: Colors.black45,
    elevation: 0,
    title: Builder(builder: (context) {
      return Txt(title, style: context.title);
    }),
    centerTitle: true,
    leading: SizedBox(
        child: leading
            ? Builder(builder: (context) {
                return InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 25, color: context.iconColor));
              })
            : null),
    actions: [
      Builder(builder: (context) {
        return InkWell(
            onTap: () {
              bool isDark = context.appThemeRead.isDark;
              context.appThemeRead.changeDarkMode(
                  isDark ? AppThemeModel.light : AppThemeModel.dark);
            },
            child: Icon(Icons.dark_mode,
                size: 25, color: context.invertedColor.withOpacity(.7)));
      }),
      const Gap(20)
    ],
  );
}
