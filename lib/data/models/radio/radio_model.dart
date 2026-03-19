// data/models/radio/radio_model.dart
class RadioStation {
  final String changeUuid;
  final String stationUuid;
  final String? serverUuid;

  final String name;
  final String url;
  final String urlResolved;
  final String homepage;
  final String favicon;

  final String tags;
  final String country;
  final String countryCode;
  final String state;

  final String language;
  final String languageCodes;

  final int votes;
  final String codec;
  final int bitrate;
  final bool hls;

  final bool lastCheckOk;
  bool favorite;
  final int clickCount;
  final int clickTrend;

  final DateTime lastChangeTime;
  final DateTime clickTime;


  RadioStation({
    required this.changeUuid,
    required this.stationUuid,
    required this.serverUuid,
    required this.name,
    required this.url,
    required this.urlResolved,
    required this.homepage,
    required this.favicon,
    required this.tags,
    required this.country,
    required this.countryCode,
    required this.state,
    required this.language,
    required this.languageCodes,
    required this.votes,
    required this.codec,
    required this.bitrate,
    required this.hls,
    required this.lastCheckOk,
    required this.clickCount,
    required this.clickTrend,
    required this.lastChangeTime,
    required this.clickTime,
    required this.favorite
  });

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      changeUuid: json['changeuuid'] ?? '',
      stationUuid: json['stationuuid'] ?? '',
      serverUuid: json['serveruuid'],
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      urlResolved: json['url_resolved'] ?? '',
      homepage: json['homepage'] ?? '',
      favicon: json['favicon'] ?? '',
      tags: json['tags'] ?? '',
      country: json['country'] ?? '',
      countryCode: json['countrycode'] ?? '',
      state: json['state'] ?? '',
      language: json['language'] ?? '',
      languageCodes: json['languagecodes'] ?? '',
      votes: json['votes'] ?? 0,
      codec: json['codec'] ?? '',
      bitrate: json['bitrate'] ?? 0,
      hls: json['hls'] == 1,
      lastCheckOk: json['lastcheckok'] == 1,
      clickCount: json['clickcount'] ?? 0,
      clickTrend: json['clicktrend'] ?? 0,
      lastChangeTime: json['lastchangetime_iso8601'] != null
          ? DateTime.parse(json['lastchangetime_iso8601'])
          : DateTime(1970),
      clickTime: json['clicktimestamp_iso8601'] != null
          ? DateTime.parse(json['clicktimestamp_iso8601'])
          : DateTime(1970),
      favorite: false,
    );
  }
}
