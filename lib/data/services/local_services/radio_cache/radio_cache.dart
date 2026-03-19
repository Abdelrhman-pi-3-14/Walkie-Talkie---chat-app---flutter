// data/services/local_services/radio_cache/radio_cache.dart
import 'package:hive_flutter/adapters.dart';
import 'package:walkie_talkie/data/models/radio/radio_model.dart';

class RadioCache {
  final Box box;

  RadioCache(this.box);

  Future<void> cacheRadioStations(List<RadioStation> stations) async {
    try {
      if (box.get('stations') == null) {
        await box.put('stations', stations);
      } else {
        await box.delete('stations');
        await box.put('stations', stations);
      }
    } catch (e) {
      print("cacheing error : $e");
    }
  }

  Future<List<RadioStation>> loadRadioCache() async {
    return await box.get('stations');
  }

  Future<void> cacheFavRadioStations(List<RadioStation> stations) async {
    try {
      for (int i = 0; i < stations.length; i++) {
        if (stations[i].favorite) {
          await box.put('fav_stations', stations);
        } else {
          await box.deleteAt(i);
        }
      }
    } catch (e) {
      print("cacheing error : $e");
    }
  }

  Future<List<RadioStation>> loadFavRadioStaions() async {
    return await box.get('fav_stations');
  }
}
