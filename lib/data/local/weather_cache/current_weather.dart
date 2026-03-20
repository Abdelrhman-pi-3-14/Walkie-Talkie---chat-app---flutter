// data/local/weather_cache/current_weather_hive_model.dart
import 'package:hive/hive.dart';

part 'current_weather.g.dart';

@HiveType(typeId: 1)
class CurrentWeather extends HiveObject {
  @HiveField(0)
  final double temperature;

  @HiveField(1)
  final int weatherId;

  @HiveField(2)
  final String countryName;

  @HiveField(3)
  final double lat;

  @HiveField(4)
  final double long;

  CurrentWeather({
    required this.temperature,
    required this.weatherId,
    required this.countryName,
    required this.lat,
    required this.long,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: (json['main']['temp'] as num).toDouble(),
      weatherId: json['weather'][0]['id'] ?? 0,
      countryName: json['name'] ?? 'Unknown',
      lat: (json['coord']['lat'] as num).toDouble(),
      long: (json['coord']['lon'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'main': {'temp': temperature},
        'weather': [
          {'id': weatherId}
        ],
        'name': countryName,
        'coord': {'lat': lat, 'lon': long},
      };
}