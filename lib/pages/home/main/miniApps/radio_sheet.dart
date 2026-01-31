import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:walkie_talkie/services/radio/radio_service.dart';
import '../../../../models/radio/radio_model.dart';

class RadioBottomSheetContent extends StatefulWidget {
  const RadioBottomSheetContent({super.key});

  @override
  State<RadioBottomSheetContent> createState() =>
      _RadioBottomSheetContentState();
}

class _RadioBottomSheetContentState extends State<RadioBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _volume = 0.5;
  bool _isPlaying = false;
  int _selectedIndex = 0;

  final AudioPlayer _player = AudioPlayer();

  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stationsController = TextEditingController();

  final RadioService _radioService = RadioService();

  List<RadioStation> stations = [];
  List<RadioStation> _topStations = [];
  RadioStation? selectedStation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadTopStations();
  }

  @override
  void dispose() {
    _countryController.dispose();
    _stationsController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadTopStations() async {
    try {
      final topStations = await _radioService.getTopStations();
      setState(() {
        _topStations = topStations;
        stations = topStations;
      });
    } catch (e) {
      debugPrint("Failed to load top stations: $e");
    }
  }

  Future<void> _search() async {
    final country = _countryController.text.trim();
    final name = _stationsController.text.trim();

    if (country.isEmpty && name.isEmpty) {
      setState(() => stations = _topStations);
      return;
    }

    List<RadioStation> results = [];

    try {
      if (country.isNotEmpty) {
        final byCountry = await _radioService.searchWithCountry(country);
        results.addAll(byCountry);
      }
      if (name.isNotEmpty) {
        final byName = await _radioService.searchByName(name);
        results.addAll(byName);
      }

      final uniqueResults = <String, RadioStation>{};
      for (var station in results) {
        uniqueResults[station.stationUuid] = station;
      }

      setState(() {
        stations = uniqueResults.values.toList();
        _selectedIndex = 0;
        selectedStation = stations.isNotEmpty ? stations[0] : null;
      });
    } catch (e) {
      debugPrint("Search failed: $e");
      setState(() => stations = _topStations); // fallback
    }
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
  }

  void _selectStation(int index) {
    setState(() {
      _selectedIndex = index;
      selectedStation = stations[index];
      _tabController.animateTo(1);
      _isPlaying = true;
    });
  }

  Future<void> playRadioStation(String streamUrl) async {
    try {
      await _player.stop();
      await _player.setUrl(streamUrl);
      await _player.play();
    } catch (e) {
      debugPrint('Radio play error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/appIcons/radio_icon.png",
                height: 70,
                width: 70,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: const Color(0xFF00BBFF),
                    labelColor: const Color(0xFF00BBFF),
                    unselectedLabelColor: Colors.white54,
                    tabs: const [
                      Tab(text: 'Stations'),
                      Tab(text: 'Now Playing'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _countryController,
                  style: const TextStyle(color: Color(0xFF00BBFF)),
                  decoration: InputDecoration(
                    hintText: 'Country',
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.public, color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _stationsController,
                  style: const TextStyle(color: Color(0xFF00BBFF)),
                  decoration: InputDecoration(
                    hintText: 'Station Name',
                    hintStyle: const TextStyle(color: Colors.white38),
                    prefixIcon: const Icon(Icons.search, color: Colors.white38),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: _search,
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: Image.asset(
                    "assets/appIcons/search_icon.png",
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Stations List
                ListView.separated(
                  itemCount: stations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final s = stations[index];
                    final isSelected = s == selectedStation;
                    return GestureDetector(
                      onTap: () {
                        _selectStation(index);
                        playRadioStation(stations[index].url);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF00BBFF).withOpacity(0.2)
                              : Colors.white12,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF00BBFF)
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  s.bitrate.toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF00BBFF),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Courier',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    s.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    s.country,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                s.favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: s.favorite
                                    ? const Color(0xFF00BBFF)
                                    : Colors.white54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Now Playing
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedStation?.bitrate.toString() ?? '--',
                      style: const TextStyle(
                        color: Color(0xFF00BBFF),
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      selectedStation != null
                          ? selectedStation!.name
                          : 'Select a station',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.volume_up,
                            color: Colors.white70,
                          ),
                          onPressed: () {},
                        ),
                        Slider(
                          value: _volume,
                          min: 0,
                          max: 1,
                          activeColor: const Color(0xFF00BBFF),
                          inactiveColor: Colors.white12,
                          onChanged: (v) => setState(() => _volume = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    FloatingActionButton(
                      onPressed: _togglePlay,
                      backgroundColor: const Color(0xFF00BBFF),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
