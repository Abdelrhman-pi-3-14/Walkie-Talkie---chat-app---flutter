// data/services/local_services/radio_cache/radio_cache.dart
import 'package:hive_flutter/adapters.dart';
import 'package:walkie_talkie/data/models/radio/radio_model.dart';

class RadioCache {
  final Box radioStationBox;
  final Box favStatioansBox;

  RadioCache({required this.radioStationBox, required this.favStatioansBox});

  Future<void> cacheRadioStations(List<RadioStation> stations) async {
    try {
      await radioStationBox.clear();
      for (var station in stations) {
        await radioStationBox.put(station.stationUuid, station);
      }
    } catch (e) {
      Exception("something went worng : $e");
    }
  }

  Future<List<RadioStation>> loadRadioCache() async {
    return radioStationBox.values.cast<RadioStation>().toList();
  }

  Future<void> cacheFavRadioStations(List<RadioStation> stations) async {
    try {
      for (var station in stations) {
        if (station.favorite == true) {
          await favStatioansBox.put(station.stationUuid, station);
        }
      }
    } catch (e) {
      Exception("cacheing error : $e");
    }
  }

  Future<List<RadioStation>> loadFavRadioStaions() async {
    return favStatioansBox.values.cast<RadioStation>().toList();
  }
}
