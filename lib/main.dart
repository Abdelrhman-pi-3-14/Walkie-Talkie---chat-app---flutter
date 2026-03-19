// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:walkie_talkie/bussnies_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:walkie_talkie/data/repositories/weather_repo.dart';
import 'package:walkie_talkie/data/services/local_services/weather_cache/weather_cacheing.dart';
import 'package:walkie_talkie/data/services/web_services/weather/weather_service.dart';
import 'constants/app_theme.dart';
import 'constants/app_routes.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await dotenv.load(fileName: "walkie_talkie.env");
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Hive.initFlutter();
  final weatherBox = await Hive.openBox('weather_box');
  final radioBox = await Hive.openBox('radio_box');

  runApp(MyApp(weatherBox: weatherBox, radioBox: radioBox));
}

class MyApp extends StatelessWidget {
  final Box weatherBox;
  final Box radioBox;

  const MyApp({super.key, required this.weatherBox, required this.radioBox});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Box box;
    final WeatherCacheing weatherCacheing = WeatherCacheing(box: weatherBox);
    final WeatherService weatherService = WeatherService();
    final WeatherRepository weatherRepository = WeatherRepository(
      weatherService: weatherService,
      weatherCacheing: weatherCacheing,
    );

    return MultiBlocProvider(
      providers:[
          BlocProvider(create: (_)=> WeatherCubit(weatherRepository))
    ],

      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().lightTheme,
        darkTheme: AppTheme().darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.auth,
        routes: AppRoutes.routes(),
      ),
    );
  }
}
