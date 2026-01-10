class WeatherCondition {
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
