// bussnies_logic/cubit/radio_cubit/radio_state.dart
part of 'radio_cubit.dart';

@immutable
sealed class RadioState {}

class RadioInitial extends RadioState {}

class RadioLoading extends RadioState {}

class RadioLoaded extends RadioState {
  final List<RadioStation> stations;
  final List<RadioStation> favorites;
  final RadioStation? selectedStation;

  RadioLoaded({
    required this.stations,
    required this.favorites,
    this.selectedStation,
  });
}

class RadioError extends RadioState {
  final String message;

  RadioError(this.message);
}