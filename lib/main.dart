import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:walkie_talkie/services/weather/current_weather_service.dart';

import 'constants/app_theme.dart';
import 'constants/app_routes.dart';

Future<void> main() async {
  final dio = Dio();
  await dotenv.load(fileName: "walkie_talkie.env");
  String? weatherApiKey = dotenv.env["WEATHER_API_KEY"];

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes(),
    );
  }
}
