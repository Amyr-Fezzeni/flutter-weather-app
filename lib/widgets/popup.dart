import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/constants/app_style.dart';
import 'package:weather_app/models/language.dart';
import 'package:weather_app/models/theme.dart';
import 'package:weather_app/models/unit_model.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:weather_app/services/util.dart';
import 'package:weather_app/widgets/extra_widgets.dart';

Future<void> customPopup({required String message}) async {
  return showDialog(
      context: NavigationService.navigatorKey.currentContext!,
      builder: (context) {
        return Dialog(
          backgroundColor: context.bgcolor,
          surfaceTintColor: context.bgcolor,
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: defaultSmallRadius),
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(10),
                  Txt(message, center: true),
                  const Gap(10),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => context.primaryColor)),
                      onPressed: () {
                        context.manageCitiesRead.deleteSelectedCities();
                        context.pop();
                      },
                      child: Txt('Ok', color: Colors.white))
                ],
              )),
        );
      });
}

Widget settingsPopup(
    {required String title,
    required UnitModel selectedValue,
    Function(UnitModel)? onTap,
    List<UnitModel> lst = const []}) {
  return Builder(builder: (context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Txt(title)),
            PopupMenuButton<UnitModel>(
              initialValue: selectedValue,
              surfaceTintColor: context.bgcolor,
              color: context.bgcolor,
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: context.w * .4),
                    child: Txt(selectedValue.name,
                        color: context.iconColor, maxLines: 2),
                  ),
                  Icon(Icons.unfold_more_rounded,
                      color: context.iconColor, size: 25.sp)
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
                              constraints: BoxConstraints(
                                  minHeight: 50.sp, minWidth: 110.sp),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: e.name == selectedValue.name
                                      ? context.appThemeRead.primaryColor
                                          .withOpacity(.1)
                                      : null),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      txt(e.description),
                                      style: context.appThemeRead.text.copyWith(
                                          fontSize: 14.sp,
                                          color: e.name == selectedValue.name
                                              ? context
                                                  .appThemeRead.primaryColor
                                              : null),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
        divider(top: 15, bottom: 15),
      ],
    );
  });
}

Widget darkModePopup() {
  return Builder(builder: (context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Txt('Dark mode'),
            PopupMenuButton<AppThemeModel>(
              initialValue: context.appThemeWatch.appTheme,
              surfaceTintColor: context.bgcolor,
              color: context.bgcolor,
              child: Row(
                children: [
                  Txt(capitalize(context.appThemeWatch.appTheme.name),
                      color: context.iconColor),
                  Icon(Icons.unfold_more_rounded,
                      color: context.iconColor, size: 25.sp)
                ],
              ),
              itemBuilder: (BuildContext context) => AppThemeModel.values
                  .map((e) => PopupMenuItem<AppThemeModel>(
                        value: e,
                        padding: const EdgeInsets.all(0),
                        onTap: () => context.appThemeRead.changeDarkMode(e),
                        child: Container(
                          color: context.appThemeRead.bgColor,
                          child: Container(
                              constraints: BoxConstraints(
                                  minHeight: 50.sp, minWidth: 110.sp),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: e.name ==
                                          context.appThemeRead.appTheme.name
                                      ? context.appThemeRead.primaryColor
                                          .withOpacity(.1)
                                      : null),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      txt(capitalize(e.name)),
                                      style: context.appThemeRead.text.copyWith(
                                          color: e.name ==
                                                  context.appThemeRead.appTheme
                                                      .name
                                              ? context
                                                  .appThemeRead.primaryColor
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
        divider(top: 15, bottom: 15),
      ],
    );
  });
}

Widget languagePopup() {
  return Builder(builder: (context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Txt('Language'),
            PopupMenuButton<LanguageModel>(
              initialValue: context.dataWatch.currentLanguage,
              surfaceTintColor: context.bgcolor,
              color: context.bgcolor,
              child: Row(
                children: [
                  Txt(capitalize(context.dataWatch.currentLanguage.name),
                      color: context.iconColor),
                  Icon(Icons.unfold_more_rounded,
                      color: context.iconColor, size: 25.sp)
                ],
              ),
              itemBuilder: (BuildContext context) => LanguageModel.values
                  .map((e) => PopupMenuItem<LanguageModel>(
                        value: e,
                        padding: const EdgeInsets.all(0),
                        onTap: () => context.dataRead.changeDefaultLanguage(e),
                        child: Container(
                          color: context.appThemeRead.bgColor,
                          child: Container(
                              constraints: BoxConstraints(
                                  minHeight: 50.sp, minWidth: 110.sp),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: e.name ==
                                          context.dataRead.currentLanguage.name
                                      ? context.appThemeRead.primaryColor
                                          .withOpacity(.1)
                                      : null),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      txt(capitalize(e.name)),
                                      style: context.appThemeRead.text.copyWith(
                                          color: e.name ==
                                                  context.dataRead
                                                      .currentLanguage.name
                                              ? context
                                                  .appThemeRead.primaryColor
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
        divider(top: 15),
      ],
    );
  });
}
