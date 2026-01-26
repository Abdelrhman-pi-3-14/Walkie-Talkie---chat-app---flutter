class WeatherCondition {
  final String main;
  final int weatherId;
  final String icon;

  WeatherCondition({
    required this.main,
    required this.weatherId,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      main: json['main'],
      weatherId: json['id'],
      icon: json['icon'],
    );
  }
}
