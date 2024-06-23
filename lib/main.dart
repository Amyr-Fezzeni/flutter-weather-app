import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/const_data.dart';
import 'package:weather_app/providers/data_provider.dart';
import 'package:weather_app/providers/manage_cities_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/services/context_extention.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:weather_app/services/local_data.dart';
import 'package:weather_app/views/home/home.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await dotenv.load(fileName: ".env");
  await LocalData.init();

  FlutterNativeSplash.remove();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ChangeNotifierProvider(create: (_) => DataProvider()),
      ChangeNotifierProvider(create: (_) => ManageCityProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
            appBarTheme: AppBarTheme(backgroundColor: context.bgcolor),
            iconTheme: IconThemeData(color: context.iconColor),
            colorScheme: ColorScheme.fromSeed(
                secondary: context.primaryColor,
                seedColor: context.primaryColor,
                background: context.bgcolor),
            useMaterial3: true),
        home: const Home(),
      ),
    );
  }
}
