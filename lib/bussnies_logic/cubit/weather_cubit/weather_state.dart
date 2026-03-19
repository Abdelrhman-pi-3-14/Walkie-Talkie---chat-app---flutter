// bussnies_logic/cubit/weather_cubit/weather_state.dart
part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final CurrentWeather currentWeather;
  final ForecastResponse forecastResponse;

  WeatherLoaded({required this.currentWeather, required this.forecastResponse});
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
