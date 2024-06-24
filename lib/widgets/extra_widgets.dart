import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/services/context_extention.dart';

Widget divider({double bottom = 0, double top = 0}) =>
    Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(top: top, bottom: bottom),
        child: Divider(
          height: 5,
          color: context.invertedColor.withOpacity(.1),
        ),
      );
    });

Widget checkBox({required bool value, required Function() function}) =>
    Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SizedBox(
          height: 20.sp,
          width: 20.sp,
          child: Checkbox(
            value: value,
            checkColor: Colors.white,
            side: MaterialStateBorderSide.resolveWith((states) =>
                BorderSide(width: 1.0, color: context.primaryColor)),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: context.primaryColor),
                borderRadius: BorderRadius.circular(4)),
            activeColor: context.primaryColor,
            onChanged: (value) {
              function();
            },
          ),
        ),
      );
    });
