// bussnies_logic/cubit/radio_cubit/radio_cubit.dart
// bussnies_logic/cubit/radio_cubit/radio_cubit.dart

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:walkie_talkie/data/models/radio/radio_model.dart';
import 'package:walkie_talkie/data/repositories/radio_repo.dart';

part 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  final RadioRepository repo;

  RadioCubit(this.repo) : super(RadioInitial());

  List<RadioStation> _stations = [];
  List<RadioStation> _favorites = [];
  RadioStation? _selected;

  Future<void> loadTopStations() async {
    emit(RadioLoading());
    try {
      _stations = await repo.getTopStations();
      _favorites = await repo.getFavStaions();

      emit(RadioLoaded(
        stations: _stations,
        favorites: _favorites,
        selectedStation: _selected,
      ));
    } catch (e) {
      emit(RadioError(e.toString()));
    }
  }

  Future<void> search(String country) async {
    emit(RadioLoading());
    try {
      _stations = await repo.getStations(country);
      _favorites = await repo.getFavStaions();

      emit(RadioLoaded(
        stations: _stations,
        favorites: _favorites,
        selectedStation: _selected,
      ));
    } catch (e) {
      emit(RadioError(e.toString()));
    }
  }

  void selectStation(RadioStation station) {
    _selected = station;

    emit(RadioLoaded(
      stations: _stations,
      favorites: _favorites,
      selectedStation: _selected,
    ));
  }

  Future<void> toggleFavorite(RadioStation station) async {
    station.favorite = !station.favorite;

    _favorites = await repo.getFavStaions();

    emit(RadioLoaded(
      stations: _stations,
      favorites: _favorites,
      selectedStation: _selected,
    ));
  }
}