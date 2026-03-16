// presentation/pages/home/main/miniApps/weather_sheet.dart
import 'package:flutter/material.dart';
import 'package:walkie_talkie/data/services/weather/weather_service.dart';

import '../../../../../data/models/weather/current_weather.dart';
import '../../../../../data/models/weather/forecast_weather.dart';


class WeatherBottomSheetContent extends StatefulWidget {
  const WeatherBottomSheetContent({super.key});

  @override
  State<WeatherBottomSheetContent> createState() =>
      _WeatherBottomSheetContentState();
}

class _WeatherBottomSheetContentState extends State<WeatherBottomSheetContent> {
  final TextEditingController _cityController = TextEditingController();

  final WeatherService weatherService = WeatherService(
    apiKey: "39225e8f147355a3be91fac642fa161a",
  );

  bool isLoadingWeather = false;
  CurrentWeather? currentWeather;
  ForecastResponse? forecastWeather;

  Future<void> fetchWeather(String city) async {
    setState(() => isLoadingWeather = true);

    try {
      final current = await weatherService.getCurrentWeather(city);
      final forecast = await weatherService.getForecast(city);

      if (!mounted) return;

      setState(() {
        currentWeather = current;
        forecastWeather = forecast;
        isLoadingWeather = false;
      });
    } catch (e) {
      setState(() => isLoadingWeather = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to fetch weather: $e')));
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),

        /// drag handle
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        const SizedBox(height: 16),

        /// search
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _cityController,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'digital',
                ),
                decoration: InputDecoration(
                  hintText: "Search city...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () => fetchWeather(_cityController.text),
              child: SizedBox(
                height: 48,
                width: 48,
                child: Image.asset(
                  "assets/appIcons/search_icon.png",
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// current weather
        _CurrentWeatherCard(
          cityName: currentWeather?.countryName,
          temp: currentWeather?.temperature,
          weatherId: currentWeather?.weatherId,
          lat: currentWeather?.lat,
          long: currentWeather?.long,
        ),

        const SizedBox(height: 24),

        /// forecast title
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Forecast",
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 16,
              fontFamily: 'digital',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// forecast list
        Expanded(
          child: ListView.separated(
            itemCount: forecastWeather?.items.length ?? 0,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = forecastWeather!.items[index];
              return _ForecastItem(
                dateTime: item.dateTime,
                temp: item.temp,
                weatherId: item.condition.weatherId,
              );
            },
          ),
        ),
      ],
    );
  }
}

/* ───────────────────────── CURRENT WEATHER ───────────────────────── */

class _CurrentWeatherCard extends StatelessWidget {
  final String? cityName;
  final double? temp;
  final int? weatherId;
  final double? lat;
  final double? long;

  const _CurrentWeatherCard({
    required this.cityName,
    required this.temp,
    required this.weatherId,
    required this.lat,
    required this.long
  });

  @override
  Widget build(BuildContext context) {
    final icon = getWeatherIcon(weatherId ?? 0);
    final color = getWeatherColor(weatherId ?? 0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cityName ?? "--,--",
                style: const TextStyle(
                  color: Color(0xFF00BBFF),
                  fontSize: 16,
                  fontFamily: 'digital',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                temp == null ? "-- °C" : "${temp!.round()} °C",
                style: const TextStyle(
                  color: Color(0xFF00BBFF),
                  fontSize: 42,
                  fontFamily: 'digital',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    temp == null ? "lat : --" : "lat : ${lat!.round()}",
                    style: const TextStyle(
                      color: Color(0xFF00BBFF),
                      fontSize: 20,
                      fontFamily: 'digital',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    temp == null ? "long : --" : "long : ${long!.round()}",
                    style: const TextStyle(
                      color: Color(0xFF00BBFF),
                      fontSize: 20,
                      fontFamily: 'digital',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(icon, size: 52, color: color),
        ],
      ),
    );
  }
}

/* ───────────────────────── FORECAST ITEM ───────────────────────── */

class _ForecastItem extends StatelessWidget {
  final DateTime? dateTime;
  final double? temp;
  final int? weatherId;

  const _ForecastItem({
    required this.dateTime,
    required this.temp,
    required this.weatherId,
  });

  @override
  Widget build(BuildContext context) {
    final icon = getWeatherIcon(weatherId ?? 0);
    final color = getWeatherColor(weatherId ?? 0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            dateTime == null
                ? "-- / -- / --"
                : "${dateTime!.day}/${dateTime!.month}",
            style: const TextStyle(
              color: Color(0xFF00BBFF),
              fontFamily: 'digital',
            ),
          ),
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                temp == null ? "-- °C" : "${temp!.round()} °C",
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'digital',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ───────────────────────── ICON MAPPER ───────────────────────── */

IconData getWeatherIcon(int id) {
  switch (id) {
    case 200:
    case 201:
    case 202:
    case 210:
    case 211:
    case 212:
    case 221:
    case 230:
    case 231:
    case 232:
      return Icons.thunderstorm;

    case 300:
    case 301:
    case 302:
    case 310:
    case 311:
    case 312:
    case 313:
    case 314:
    case 321:
      return Icons.grain;

    case 500:
    case 501:
    case 502:
    case 503:
    case 504:
    case 511:
    case 520:
    case 521:
    case 522:
    case 531:
      return Icons.umbrella;

    case 600:
    case 601:
    case 602:
    case 611:
    case 612:
    case 613:
    case 615:
    case 616:
    case 620:
    case 621:
    case 622:
      return Icons.ac_unit;

    case 701:
    case 711:
    case 721:
    case 731:
    case 741:
    case 751:
    case 761:
    case 762:
    case 771:
    case 781:
      return Icons.foggy;

    case 800:
      return Icons.wb_sunny;

    case 801:
    case 802:
    case 803:
    case 804:
      return Icons.cloud;

    default:
      return Icons.ac_unit_sharp;
  }
}

/* ───────────────────────── COLOR MAPPER ───────────────────────── */

Color getWeatherColor(int id) {
  if (id >= 200 && id < 300) return Colors.deepPurpleAccent; // thunder
  if (id >= 300 && id < 400) return Colors.lightBlueAccent; // drizzle
  if (id >= 500 && id < 600) return Colors.blueAccent; // rain
  if (id >= 600 && id < 700) return Colors.white; // snow
  if (id >= 700 && id < 800) return Colors.grey; // fog
  if (id == 800) return Colors.orangeAccent; // clear
  if (id > 800) return Colors.blueGrey; // clouds
  return Colors.white;
}
