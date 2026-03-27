// presentation/pages/home/main/miniApps/weather/screens/weather_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walkie_talkie/bussnies_logic/cubit/weather_cubit/weather_cubit.dart';

class WeatherBottomSheetContent extends StatelessWidget {
  WeatherBottomSheetContent({super.key});

  final TextEditingController _cityController = TextEditingController();

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

        /// CITY SEARCH
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _cityController,
                style: const TextStyle(color: Colors.white),
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
              onTap: () {
                // Update cached weather for this city
                final city = _cityController.text.trim();
                if (city.isNotEmpty) {
                  context.read<WeatherCubit>().updateWeatherInBackground(city);
                }
              },
              child: const Icon(Icons.search, color: Colors.lightBlueAccent),
            ),
          ],
        ),

        const SizedBox(height: 20),

        /// WEATHER DISPLAY
        Expanded(
          child: BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is WeatherError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is WeatherLoaded) {
                final current = state.currentWeather;
                final forecast = state.forecastResponse;

                if (current == null && (forecast?.items.isEmpty ?? true)) {
                  return const Center(
                    child: Text(
                      "No cached data. Search for a city!",
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                }

                return Column(
                  children: [
                    /// CURRENT WEATHER
                    _CurrentWeatherCard(
                      cityName: current?.countryName,
                      temp: current?.temperature,
                      weatherId: current?.weatherId,
                      lat: current?.lat,
                      long: current?.long,
                    ),

                    const SizedBox(height: 24),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forecast",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// FORECAST LIST
                    if (forecast != null && forecast.items.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          itemCount: forecast.items.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = forecast.items[index];
                            return _ForecastItem(
                              dateTime: item.dateTime,
                              temp: item.temp,
                              weatherId: item.condition.weatherId,
                            );
                          },
                        ),
                      )
                    else
                      const Expanded(
                        child: Center(
                          child: Text(
                            "No forecast data available",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ),
                  ],
                );
              }

              return const Center(
                child: Text(
                  "Search for a city",
                  style: TextStyle(color: Colors.white54),
                ),
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
    required this.long,
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
                temp != null ? "${temp!.round()} °C" : "-- °C",
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
                    lat != null ? "lat : ${lat!.round()}" : "lat : --",
                    style: const TextStyle(
                      color: Color(0xFF00BBFF),
                      fontSize: 20,
                      fontFamily: 'digital',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    long != null ? "long : ${long!.round()}" : "long : --",
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
            dateTime != null
                ? "${dateTime!.day}/${dateTime!.month}"
                : "-- / -- / --",
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
                temp != null ? "${temp!.round()} °C" : "-- °C",
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
  if (id >= 200 && id < 300) return Icons.thunderstorm;
  if (id >= 300 && id < 400) return Icons.grain;
  if (id >= 500 && id < 600) return Icons.umbrella;
  if (id >= 600 && id < 700) return Icons.ac_unit;
  if (id >= 700 && id < 800) return Icons.foggy;
  if (id == 800) return Icons.wb_sunny;
  if (id > 800) return Icons.cloud;
  return Icons.ac_unit_sharp;
}

Color getWeatherColor(int id) {
  if (id >= 200 && id < 300) return Colors.deepPurpleAccent;
  if (id >= 300 && id < 400) return Colors.lightBlueAccent;
  if (id >= 500 && id < 600) return Colors.blueAccent;
  if (id >= 600 && id < 700) return Colors.white;
  if (id >= 700 && id < 800) return Colors.grey;
  if (id == 800) return Colors.orangeAccent;
  if (id > 800) return Colors.blueGrey;
  return Colors.white;
}