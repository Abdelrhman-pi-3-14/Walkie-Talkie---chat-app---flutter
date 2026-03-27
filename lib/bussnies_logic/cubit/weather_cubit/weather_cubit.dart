// bussnies_logic/cubit/weather_cubit/weather_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:walkie_talkie/data/models/weather/current_weather.dart';
import 'package:walkie_talkie/data/models/weather/forecast_weather.dart';
import 'package:walkie_talkie/data/repositories/weather_repo.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repo;

  WeatherCubit(this.repo) : super(WeatherInitial());

Future<void> getWeather({String? cityName}) async {
  emit(WeatherLoading());

  try {
    final current = repo.getCachedCurrentWeather();
    final forecast = repo.getCachedForecast();

    // If no cached data, emit a "placeholder" object to avoid nulls
    if (current == null || forecast == null) {
      emit(WeatherLoaded(
        currentWeather: CurrentWeather.empty(),  // <-- placeholder
        forecastResponse: ForecastResponse.empty(), // <-- placeholder
      ));

      // If user provided cityName, fetch from API and cache
      if (cityName != null && cityName.isNotEmpty) {
        final updatedCurrent = await repo.updateCurrentWeather(cityName);
        final updatedForecast = await repo.updateForecastWeather(cityName);

        emit(WeatherLoaded(
          currentWeather: updatedCurrent,
          forecastResponse: updatedForecast,
        ));
      }
      return;
    }

    emit(WeatherLoaded(currentWeather: current, forecastResponse: forecast));
  } catch (e) {
    emit(WeatherError(e.toString()));
  }
}


Future<void> updateWeatherInBackground(String cityName) async {
  try {
    final updatedCurrentWeather = await repo.updateCurrentWeather(cityName);
    final updatedForecast = await repo.updateForecastWeather(cityName);

    emit(WeatherLoaded(
      currentWeather: updatedCurrentWeather,
      forecastResponse: updatedForecast,
    ));
  } catch (_) {
    // silently fail, keep showing cached data
  }
}
}
