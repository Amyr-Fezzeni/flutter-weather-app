import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/data_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/services/ext.dart';
import 'package:weather_app/services/navigation_service.dart';
import 'package:weather_app/services/shared_data.dart';
import 'package:weather_app/views/home/home.dart';
import 'package:weather_app/views/splash%20screen/splash_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: ".env");
  await DataPrefrences.init();
  FlutterNativeSplash.remove();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppThemeProvider()),
      ChangeNotifierProvider(create: (_) => DataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
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
    );
  }
}
