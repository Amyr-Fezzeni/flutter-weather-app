import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/language.dart';

AppBar appBar(String title, {leading = true, Widget? leadingWidget}) {
  return AppBar(
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    title: Builder(builder: (context) => Txt(title, style: context.title)),
    centerTitle: true,
    leading: SizedBox(
        child: leadingWidget ??
            (leading
                ? Builder(builder: (context) {
                    return InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: 25.sp, color: context.iconColor));
                  })
                : null)),
  );
}
