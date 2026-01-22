import 'package:flutter/material.dart';
import 'package:walkie_talkie/pages/home/radio_sheet.dart';
import 'package:walkie_talkie/pages/home/weather_sheet.dart';
import 'package:walkie_talkie/pages/status_page.dart';
import '../../constants/rosponsive_helper.dart';
import '../../services/weather/current_weather_service.dart';
import '../channels_page.dart';
import '../messages_page.dart';
import '../../models/weather/current_weather.dart';

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


  final TextEditingController _controller = TextEditingController();

  bool isLoadingWeather = false;
  CurrentWeather? currentWeather;

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile
                const SizedBox(height: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Connection & Friends Card
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white12.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white24),
                        ),
                        height: r.h(0.1),
                        width: r.w(0.6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
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
                            ),
                            const SizedBox(width: 8),
                            Column(
                              children: [
                                Text(
                                  "Status: Connected",
                                  style: const TextStyle(
                                    color: Color(0xFF00BBFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'digital',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Online Friends: 70",
                                  style: const TextStyle(
                                    color: Color(0xFF00BBFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'digital',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Weather Card
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              showWeatherBottomSheet(context);
                            },
                            child: Container(
                              width: r.h(0.13),
                              height: r.h(.2),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white12.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'digital',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Icon(
                                        Icons.wb_sunny,
                                        color: Colors.orangeAccent,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    currentWeather != null
                                        ? currentWeather!.countryName
                                        : "---, ---",
                                    style: const TextStyle(
                                      color: Color(0xFF009DFF),
                                      fontSize: 13,
                                      fontFamily: 'digital',
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    currentWeather != null
                                        ? "lat ${currentWeather!.lat}"
                                        : "lat --",
                                    style: const TextStyle(
                                      color: Color(0xFF009DFF),
                                      fontSize: 12,
                                      fontFamily: 'digital',
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    currentWeather != null
                                        ? "long ${currentWeather!.long}"
                                        : "long --",
                                    style: const TextStyle(
                                      color: Color(0xFF009DFF),
                                      fontSize: 12,
                                      fontFamily: 'digital',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Radio Card
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) {
                            final height =
                                MediaQuery.of(context).size.height * 0.7;
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                              ),
                              child: Container(
                                height: height,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 4, 40, 69),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(16),
                                child: const RadioBottomSheetContent(),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 250,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white12.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: Image.asset(
                                "assets/appIcons/radio_icon.png",
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              " dsfasdfs  FM",
                              style: const TextStyle(
                                color: Color(0xFF00BBFF),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'digital',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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

void showWeatherBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      final height = MediaQuery.of(context).size.height * 0.7;

      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 4, 40, 69),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const WeatherBottomSheetContent(),
        ),
      );
    },
  );
}




