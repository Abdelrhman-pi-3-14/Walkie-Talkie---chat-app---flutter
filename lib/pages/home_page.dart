import 'package:flutter/material.dart';
import 'package:walkie_talkie/pages/status_page.dart';
import '../constants/rosponsive_helper.dart';
import '../services/weather/current_weather_service.dart';
import 'channels_page.dart';
import 'messages_page.dart';
import '../models/weather/current_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> items = [
    "assets/appIcons/messeges_icon.png",
    "assets/appIcons/groups_icon.png",
    "assets/appIcons/status_icon.png",
  ];

  final WeatherService weatherService = WeatherService(
    apiKey: "39225e8f147355a3be91fac642fa161a",
  );
  final TextEditingController _controller = TextEditingController();

  bool isLoadingWeather = false;
  CurrentWeather? currentWeather;

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchWeather(String cityName) async {
    setState(() {
      isLoadingWeather = true;
    });

    try {
      final weather = await weatherService.getCurrentWeather(cityName);
      setState(() {
        currentWeather = weather;
        isLoadingWeather = false;
      });
    } catch (e) {
      setState(() {
        isLoadingWeather = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to fetch weather: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 40, 69),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 4, 40, 69)),
              child: SizedBox(),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Home')),
            ListTile(leading: Icon(Icons.info), title: Text('About')),
            ListTile(leading: Icon(Icons.history), title: Text('History')),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: r.h(0.25),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 👤 Profile pic
                Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      borderRadius: BorderRadius.circular(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/male_user.png",
                          height: 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(height: 24),

                          Text(
                            "Status : connected",
                            style: TextStyle(
                              color: Color(0xFF00BBFF),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'digital',
                            ),
                          ),
                          Text(
                            "Online Friends : 70",
                            style: TextStyle(
                              color: Color(0xFF00BBFF),
                              fontSize: 15,
                              fontFamily: 'digital',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),

                      /// 🌤 Weather Widget
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  topLeft: Radius.circular(16),
                                ),
                                child: Container(
                                  height: r.h(0.7),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 4, 40, 69),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      /// 🌤 MAIN ICON
                                      Image.asset(
                                        "assets/appIcons/find_weather_icon.png",
                                        height: 180,
                                      ),
                                      const SizedBox(height: 16),

                                      /// 🔀 Conditional UI
                                      if (isLoadingWeather)
                                        const Text(
                                          "Finding Weather...",
                                          style: TextStyle(
                                            color: Color(0xFF00BBFF),
                                            fontSize: 22,
                                            fontFamily: 'digital',
                                          ),
                                        )
                                      else if (currentWeather != null)
                                        Column(
                                          children: [
                                            Text(
                                              "${currentWeather!.temperature.toStringAsFixed(1)}°C",
                                              style: const TextStyle(
                                                color: Color(0xFF00BBFF),
                                                fontSize: 22,
                                                fontFamily: 'digital',
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              currentWeather!.countryName,
                                              style: const TextStyle(
                                                color: Color(0xFF00BBFF),
                                                fontSize: 18,
                                                fontFamily: 'digital',
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            /*
                                            Image.network(
                                              "https://openweathermap.org/img/wn/${currentWeather}@2x.png",
                                              height: 50,
                                            ),
*/
                                          ],
                                        )
                                      else
                                        const SizedBox(height: 24),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _controller,
                                              style: const TextStyle(
                                                color: Color(0xFF00BBFF),
                                                fontFamily: 'digital',
                                              ),
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Enter Country , City",
                                                hintStyle: const TextStyle(
                                                  color: Color(0xFF00BBFF),
                                                  fontFamily: 'digital',
                                                ),
                                                filled: true,
                                                fillColor: const Color.fromARGB(
                                                  255,
                                                  4,
                                                  40,
                                                  69,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 16,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFF00BBFF,
                                                            ),
                                                            width: 2,
                                                          ),
                                                    ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                      borderSide:
                                                          const BorderSide(
                                                            color: Color(
                                                              0xFF00FFFF,
                                                            ),
                                                            width: 2.5,
                                                          ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          InkWell(
                                            onTap: () {
                                              final city = _controller.text;
                                              if (city.isNotEmpty) {
                                                fetchWeather(city);
                                              }
                                              _controller.text = "";
                                            },
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                            ),
                                            child: Container(
                                              height: 56,
                                              width: 56,
                                              padding: const EdgeInsets.all(14),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  6,
                                                  50,
                                                  87,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Image.asset(
                                                "assets/appIcons/search_icon.png",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  currentWeather != null
                                      ? "${currentWeather!.temperature.toStringAsFixed(1)}°"
                                      : "--°",
                                  style: const TextStyle(
                                    color: Color(0xFF009DFF),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'digital',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.wb_sunny,
                                  color: Colors.orangeAccent,
                                  size: 28,
                                ),
                              ],
                            ),
                            Text(
                              currentWeather != null
                                  ? currentWeather!.countryName
                                  : "---, ---",
                              style: const TextStyle(
                                color: Color(0xFF009DFF),
                                fontSize: 16,
                                fontFamily: 'digital',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  currentWeather != null
                                      ? currentWeather!.lat
                                      : "---, ---",
                                  style: const TextStyle(
                                    color: Color(0xFF009DFF),
                                    fontSize: 12,
                                    fontFamily: 'digital',
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  currentWeather != null
                                      ? currentWeather!.long
                                      : "---, ---",
                                  style: const TextStyle(
                                    color: Color(0xFF009DFF),
                                    fontSize: 12,
                                    fontFamily: 'digital',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔷 MAIN CONTENT
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  /// 🔁 PageView
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: items.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            key: ValueKey(index),
                            child: switch (index) {
                              0 => const MessagesPage(),
                              1 => const GroupPage(),
                              2 => const StatusPage(),
                              _ => Container(),
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(items.length, (index) {
                      final bool isSelected = index == _currentIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: isSelected ? 120 : 10,
                        height: isSelected ? 32 : 10,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: isSelected
                            ? Center(
                                child: Image.asset(
                                  items[index],
                                  width: 100,
                                  height: r.h(0.1),
                                ),
                              )
                            : null,
                      );
                    }),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
