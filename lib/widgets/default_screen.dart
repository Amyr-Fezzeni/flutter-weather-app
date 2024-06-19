import 'package:flutter/material.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/widgets/appbar.dart';

class DefaultScreen extends StatelessWidget {
  final String title;
  final bool appbar;
  final bool leading;
  const DefaultScreen(
      {super.key,
      required this.title,
      this.leading = true,
      this.appbar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar ? appBar(title, leading: leading) : null,
      backgroundColor: context.bgcolor,
      body: Center(
          child: Text(
        title,
        style: context.text,
      )),
    );
  }
}

// Widget loader() => const SizedBox(
//       height: 50,
//       width: 50,
//       child: CircularProgressIndicator(
//         color: blue,
//         strokeWidth: 2,
//       ),
//     );
