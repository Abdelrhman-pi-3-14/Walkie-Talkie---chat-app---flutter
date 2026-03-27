// data/repositories/radio_repo.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:walkie_talkie/data/models/radio/radio_model.dart';
import 'package:walkie_talkie/data/services/local_services/radio_cache/radio_cache.dart';
import 'package:walkie_talkie/data/services/web_services/radio/radio_service.dart';

class RadioRepository {
  final RadioService radioService;
  final RadioCache radioCache;

  RadioRepository(this.radioService, this.radioCache);

  Future<List<RadioStation>> getStations(String country) async {
    try {
      final stations = await radioService.searchWithCountry(country);
      for (var station in stations) {
        debugPrint(station.name); // or whatever field you have
      }

      await radioCache.cacheRadioStations(stations);

      return stations;
    } catch (e) {
      final cached = await radioCache.loadRadioCache();

      throw Exception("No radio stations available");
    }
  }

  Future<List<RadioStation>> getTopStations() async {
    try {
      final stations = await radioService.getTopStations(limit: 70);

      await radioCache.cacheRadioStations(stations);

      return stations;
    } catch (e) {
      final cached = await radioCache.loadRadioCache();

      if (cached.isNotEmpty) {
        return cached;
      }

      throw Exception("No stations available :( ");
    }
  }

  Future<List<RadioStation>> getFavStaions() async {
    final fav = await radioCache.loadFavRadioStaions();
    if (fav != null) {
      return fav;
    } else {
      return [];
    }
  }
}
