// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:walkie_talkie/bussnies_logic/cubit/radio_cubit/radio_cubit.dart';
import 'package:walkie_talkie/bussnies_logic/cubit/weather_cubit/weather_cubit.dart';
import 'package:walkie_talkie/data/local/radio_cache/radio_model.dart';
import 'package:walkie_talkie/data/local/weather_cache/current_weather.dart';
import 'package:walkie_talkie/data/local/weather_cache/forecast_weather.dart';
import 'package:walkie_talkie/data/local/weather_cache/weather_condetion.dart';
import 'package:walkie_talkie/data/repositories/radio_repo.dart';
import 'package:walkie_talkie/data/repositories/weather_repo.dart';
import 'package:walkie_talkie/data/services/local_services/radio_cache/radio_cache.dart';
import 'package:walkie_talkie/data/services/local_services/weather_cache/weather_cacheing.dart';
import 'package:walkie_talkie/data/services/web_services/radio/radio_service.dart';
import 'package:walkie_talkie/data/services/web_services/weather/weather_service.dart';
import 'constants/app_theme.dart';
import 'constants/app_routes.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await dotenv.load(fileName: "walkie_talkie.env");
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Hive Adaptors
  await Hive.initFlutter();
  Hive.registerAdapter(RadioStationAdapter());
  Hive.registerAdapter(CurrentWeatherAdapter());
  Hive.registerAdapter(ForecastWeatherAdapter());
  Hive.registerAdapter(ForecastResponseAdapter());
  Hive.registerAdapter(WeatherConditionAdapter());

  // open the hive boxes
  final radioBox = await Hive.openBox<RadioStation>("radio_stations");
  final favRadioBox = await Hive.openBox<RadioStation>("fav_Radio");
  final currentWeatherBox = await Hive.openBox<CurrentWeather>(
    "current_weather",
  );
  final forcastBox = await Hive.openBox<ForecastResponse>("weather_forecast");

  runApp(
    MyApp(
      weatherBox: currentWeatherBox,
      radioBox: radioBox,
      favRadio: favRadioBox,
      foreCast: forcastBox,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Box<CurrentWeather> weatherBox;
  final Box<RadioStation> radioBox;
  final Box<RadioStation> favRadio;
  final Box<ForecastResponse> foreCast;

  const MyApp({
    super.key,
    required this.weatherBox,
    required this.radioBox,
    required this.favRadio,
    required this.foreCast,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final WeatherCaching weatherCacheing = WeatherCaching(
      currentWeatherBox: weatherBox,
      forecastBox: foreCast,
    );
    final WeatherService weatherService = WeatherService();
    final WeatherRepository weatherRepository = WeatherRepository(
      weatherService: weatherService,
      weatherCacheing: weatherCacheing,
    );

    final RadioCache radioCache = RadioCache( radioStationBox: radioBox, favStatioansBox: favRadio);
    final RadioService radioService = RadioService();
    final RadioRepository radioRepository = RadioRepository(
      radioService,
      radioCache,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WeatherCubit(weatherRepository)),
        BlocProvider(create: (_) => RadioCubit(radioRepository)),
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
