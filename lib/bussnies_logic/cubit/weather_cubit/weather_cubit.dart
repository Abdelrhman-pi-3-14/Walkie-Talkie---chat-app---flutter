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

  Future<void> getWeather(String cityName) async {
    emit(WeatherLoading());
    try {
      final current = await repo.fetchCurrentWeather(cityName);
      final forecast = await repo.fetchForeCastWeather(cityName);

      emit(WeatherLoaded(currentWeather: current, forecastResponse: forecast));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
} 
