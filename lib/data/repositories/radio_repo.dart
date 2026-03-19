// data/repositories/radio_repo.dart
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

      await radioCache.cacheRadioStations(stations);

      return stations;
    } catch (e) {
      final cached = await radioCache.loadRadioCache();

      if (cached.isNotEmpty) {
        return cached;
      }

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

      throw Exception("No stations available");
    }
  }

  Future<List<RadioStation>> getFavStaions() async {
    return await radioCache.loadFavRadioStaions();
  }
}