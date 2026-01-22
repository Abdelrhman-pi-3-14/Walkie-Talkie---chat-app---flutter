import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walkie_talkie/models/weather/forecast_weather.dart';
import 'package:walkie_talkie/services/weather/current_weather_service.dart';

import '../../models/weather/current_weather.dart';

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
  ForecastWeather? forecastWeather;

  Future<void> fetchCurrentWeather(String cityName) async {
    setState(() {
      isLoadingWeather = true;
    });

    try {
      final weather = await weatherService.getCurrentWeather(cityName);
      setState(() {
        currentWeather = weather;
        isLoadingWeather = false;
      });
    } catch (e) {
      setState(() {
        isLoadingWeather = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to fetch weather: $e')));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 5,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

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
                  hintStyle: TextStyle(color: Colors.white54),
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
              onTap: () {
                fetchCurrentWeather(_cityController.text);
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  "assets/appIcons/search_icon.png",
                  color: Colors.lightBlueAccent,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// 🌡 Current Weather
        _CurrentWeatherCard(cityName: currentWeather?.countryName,temp: currentWeather?.temperature.toString(), ),

        const SizedBox(height: 24),

        /// 📅 Forecast Title
        Align(
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

        /// 📅 Forecast List
        Expanded(
          child: ListView.separated(
            itemCount: 7,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _ForecastItem(day: "Day ${index + 1}");
            },
          ),
        ),
      ],
    );
  }
}

class _CurrentWeatherCard extends StatelessWidget {

  final String? cityName;
  final String?temp;

  const _CurrentWeatherCard({
    required this.cityName,
    required this.temp
  });

  @override
  Widget build(BuildContext context) {
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
                cityName?? "-- , --",
                style: const TextStyle(
                  color: Color(0xFF00BBFF),
                  fontSize: 16,
                  fontFamily: 'digital',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                temp?? "--,-- ",
                style: TextStyle(
                  color: Color(0xFF00BBFF),
                  fontSize: 42,
                  fontFamily: 'digital',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(Icons.wb_sunny, color: Colors.orangeAccent, size: 48),
        ],
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {
  final String day;

  const _ForecastItem({required this.day});

  @override
  Widget build(BuildContext context) {
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
            day,
            style: const TextStyle(
              color: Color(0xFF00BBFF),
              fontFamily: 'digital',
            ),
          ),
          Row(
            children: const [
              Icon(Icons.cloud, color: Colors.white70, size: 20),
              SizedBox(width: 8),
              Text(
                "22° / 15°",
                style: TextStyle(color: Colors.white, fontFamily: 'digital'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
