import 'package:flutter/material.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/services/language.dart';

Widget cLoader({double size = 50}) {
  return SizedBox(
    height: size,
    width: size,
    child: const Center(child: CircularProgressIndicator()),
  );
}

Widget divider({double bottom = 0, double top = 0}) =>
    Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(top: top, bottom: bottom),
        child: Divider(
          height: 5,
          color: context.invertedColor.withOpacity(.3),
        ),
      );
    });

Widget buildMenuTile(
    {required String title,
    String subtitle = '',
    required IconData icon,
    Widget? screen,
    Function()? onClick}) {
  return Builder(builder: (context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: 40,
      child: InkWell(
        onTap: () async {
          Scaffold.of(context).closeDrawer();
          await Future.delayed(const Duration(milliseconds: 100))
              .then((value) => {if (screen != null) context.moveTo(screen)});
          if (onClick != null) {
            onClick();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(icon, color: context.invertedColor.withOpacity(.7)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Txt(title),
                if (subtitle.isNotEmpty)
                  Txt(subtitle,
                      style: context.text.copyWith(
                          fontSize: 12,
                          color: context.invertedColor.withOpacity(.7))),
              ],
            ),
          ],
        ),
      ),
    );
  });
}
