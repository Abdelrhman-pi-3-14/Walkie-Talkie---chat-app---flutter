// presentation/pages/home/main/miniApps/radio/screens/radio_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:walkie_talkie/bussnies_logic/cubit/radio_cubit/radio_cubit.dart';
import '../../../../../../../data/models/radio/radio_model.dart';

class RadioBottomSheetContent extends StatelessWidget {
  const RadioBottomSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 12),

          /// Tabs
          const TabBar(
            tabs: [
              Tab(text: "Stations"),
              Tab(text: "Favorites"),
              Tab(text: "Now Playing"),
            ],
          ),

          /// Search
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(hintText: "Search country"),
              onSubmitted: (value) {
               String country = value.trim(); 
               country = country.toLowerCase(); 
               country = country.replaceAll(RegExp(r'\s+'), ' ');
               debugPrint("this the country value : $country");
              context.read<RadioCubit>().search(country);
              },
            ),
          ),

          /// Content
          Expanded(
            child: BlocBuilder<RadioCubit, RadioState>(
              builder: (context, state) {
                if (state is RadioLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is RadioError) {
                  return Center(child: Text(state.message));
                }

                if (state is RadioLoaded) {
                  return TabBarView(
                    children: [
                      _RadioList(state.stations),
                      _RadioList(state.favorites),
                      _NowPlaying(state.selectedStation),
                    ],
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RadioList extends StatelessWidget {
  final List<RadioStation> stations;

  const _RadioList(this.stations);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final s = stations[index];

        return ListTile(
          title: Text(s.name),
          subtitle: Text(s.country),
          onTap: () {
            context.read<RadioCubit>().selectStation(s);
          },
          trailing: IconButton(
            onPressed: () {
              context.read<RadioCubit>().toggleFavorite(s);
            },
            icon: Icon(
              s.favorite ? Icons.favorite : Icons.favorite_border,
              color: s.favorite ? Colors.red : null,
            ),
          ),
        );
      },
    );
  }
}

class _NowPlaying extends StatefulWidget {
  final RadioStation? station;

  const _NowPlaying(this.station);

  @override
  State<_NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<_NowPlaying> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  double _volume = 0.5;

  Future<void> playRadio(String url) async {
    setState(() => _isPlaying = !_isPlaying);

    if (_isPlaying) {
      await _player.setUrl(url);
      await _player.play();
    } else {
      await _player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final station = widget.station;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          station?.name ?? "No station selected",
          style: const TextStyle(color: Colors.white),
        ),

        const SizedBox(height: 20),

        Slider(
          value: _volume,
          onChanged: (v) {
            setState(() => _volume = v);
            _player.setVolume(v);
          },
        ),

        const SizedBox(height: 20),

        FloatingActionButton(
          onPressed: () {
            if (station != null) {
              playRadio(station.url);
            }
          },
          child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
        ),
      ],
    );
  }
}
