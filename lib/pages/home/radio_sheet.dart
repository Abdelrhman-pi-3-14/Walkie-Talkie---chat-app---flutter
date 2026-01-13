import 'package:flutter/material.dart';

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
  String _searchCountry = '';
  String _searchStation = '';

  final List<Station> stations = [
    Station(freq: '98.3', name: 'Radio Mirchi', subtitle: 'Top 20', country: 'India', favorite: true),
    Station(freq: '94.3', name: 'My FM', subtitle: 'Hits', country: 'India', favorite: true),
    Station(freq: '93.5', name: 'Red FM', subtitle: 'Bollywood', country: 'India', favorite: false),
    Station(freq: '104.0', name: 'Love FM', subtitle: 'Romance', country: 'USA', favorite: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
  }

  void _selectStation(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(1);
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredStations = stations.where((s) {
      return s.country.toLowerCase().contains(_searchCountry.toLowerCase()) &&
          s.name.toLowerCase().contains(_searchStation.toLowerCase());
    }).toList();

    final selectedStation = stations[_selectedIndex];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF041f45), // dark blue like HomePage
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
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
          // Header + tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Retro Radio',
                style: TextStyle(
                  color: Color(0xFF00BBFF), // match HomePage accent
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier',
                ),
              ),
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
          // Two mini search bars
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (v) => setState(() => _searchCountry = v),
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
                  onChanged: (v) => setState(() => _searchStation = v),
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
            ],
          ),
          const SizedBox(height: 12),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Stations tab
                ListView.separated(
                  itemCount: filteredStations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final s = filteredStations[index];
                    final isSelected = s == stations[_selectedIndex];
                    return GestureDetector(
                      onTap: () => _selectStation(stations.indexOf(s)),
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
                            // Frequency
                            Container(
                              width: 60,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    s.freq,
                                    style: const TextStyle(
                                      color: Color(0xFF00BBFF),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Courier',
                                    ),
                                  ),
                                  const Text(
                                    'FM',
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Station info
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
                                    '${s.subtitle} • ${s.country}',
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Favorite
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  final idx = stations.indexOf(s);
                                  stations[idx] =
                                      s.copyWith(favorite: !s.favorite);
                                });
                              },
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
                // Now Playing tab
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedStation.freq,
                      style: const TextStyle(
                        color: Color(0xFF00BBFF),
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${selectedStation.name} - ${selectedStation.subtitle}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Play / Volume
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.volume_up,
                              color: Colors.white70),
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

/// Station model
class Station {
  final String freq;
  final String name;
  final String subtitle;
  final String country;
  final bool favorite;

  Station({
    required this.freq,
    required this.name,
    required this.subtitle,
    this.country = '',
    this.favorite = false,
  });

  Station copyWith({
    String? freq,
    String? name,
    String? subtitle,
    String? country,
    bool? favorite,
  }) {
    return Station(
      freq: freq ?? this.freq,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      country: country ?? this.country,
      favorite: favorite ?? this.favorite,
    );
  }
}
