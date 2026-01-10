class CurrentWeather {
  final double temperature;
  final String condition;
  final String countryName;
  final String lat;
  final String long;


  CurrentWeather({
    required this.temperature,
    required this.condition,
    required this.countryName,
    required this.lat,
    required this.long,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: (json['main']['temp'] as num ?? 0).toDouble(),
      condition: json['weather'][0]['main'] ?? 'Unknown',
      countryName: json['name'] ?? 'Unknown',
      lat: json['coord']['lat'].toString(),
      long: json['coord']['lon'].toString(),
    );
  }
}
