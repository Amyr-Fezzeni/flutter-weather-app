import 'package:flutter/material.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/views/city/manage_cities.dart';
import 'package:weather_app/views/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.bgcolor,
      appBar: AppBar(
        backgroundColor: context.bgcolor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => context.moveTo(const ManageCities()),
              icon: Icon(Icons.add, color: context.iconColor, size: 25)),
          MenuAnchor(
              builder: (BuildContext context, MenuController controller,
                  Widget? child) {
                return IconButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: Icon(Icons.more_vert_rounded,
                      color: context.iconColor, size: 25),
                  tooltip: 'Show menu',
                );
              },
              menuChildren: [
                MenuItemButton(
                  onPressed: () => context.moveTo(const Settings()),
                  child: const Text('Settings'),
                )
              ])
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [Container()],
            ),
          ),
        ),
      ),
    );
  }
}
