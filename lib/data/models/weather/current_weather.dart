// data/models/weather/current_weather.dart
class CurrentWeather {
  final double temperature;
  final int weatherId;
  final String countryName;
  final double lat;
  final double long;


  CurrentWeather({
    required this.temperature,
    required this.weatherId,
    required this.countryName,
    required this.lat,
    required this.long,
  });


    factory CurrentWeather.empty() {
    return CurrentWeather(
      countryName: "--",
      temperature: 0,
      weatherId: 800, 
      lat: 0,
      long: 0,
    );
  }


  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: (json['main']['temp'] as num ).toDouble(),
      weatherId: json['weather'][0]['id'] ?? 'Unknown',
      countryName: json['name'] ?? 'Unknown',
      lat: json['coord']['lat'],
      long: json['coord']['lon'],
    );
  }
}
