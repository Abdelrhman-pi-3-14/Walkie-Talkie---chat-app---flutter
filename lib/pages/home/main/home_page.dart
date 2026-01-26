import 'package:flutter/material.dart';
import 'package:walkie_talkie/pages/home/main/miniApps/radio_sheet.dart';
import 'package:walkie_talkie/pages/home/status/status_page.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/rosponsive_helper.dart';
import '../../../models/weather/current_weather.dart';
import '../channels/channels_page.dart';
import '../chats/messages_page.dart';
import 'miniApps/weather_sheet.dart';

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
        backgroundColor: const Color(0xFF0B1A2A),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage:
                      AssetImage("assets/images/male_user.png"),
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      "Abdelrhman Ahmed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Flutter & Android Developer",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const ListTile(
                leading: Icon(Icons.chat_bubble_outline, color: Colors.white70),
                title: Text(
                  'Chats',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const ListTile(
                leading: Icon(Icons.person_outline, color: Colors.white70),
                title: Text(
                  'Contacts',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const Divider(color: Colors.white24),

              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.settings);
                }
                ,
                leading: const Icon(Icons.settings_outlined, color: Colors.white70),
                title: const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const Divider(color: Colors.white24),

              /// 🚪 LOGOUT
              const ListTile(
                leading: Icon(Icons.logout, color: Colors.redAccent),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: r.h(0.27),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Connection & Friends Card
                    Column(
                      children: [
                        Builder(
                          builder: (context) {
                            return InkWell(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white12.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white24),
                                ),
                                height: r.h(0.1),
                                width: r.w(0.6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        "assets/images/male_user.png",
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Column(
                                      children: const [
                                        Text(
                                          "Status : Connected",
                                          style: TextStyle(
                                            color: Color(0xFF00BBFF),
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'digital',
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          "Online Friends : 70",
                                          style: TextStyle(
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
                            );
                          },
                        ),
                        const SizedBox(height: 16),
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
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.7;
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        topLeft: Radius.circular(16),
                                      ),
                                      child: Container(
                                        height: height,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            4,
                                            40,
                                            69,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
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
                                  color: Colors.white12.withValues(alpha: 0.15),
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
                      ],
                    ),

                    // weather card
                    InkWell(
                      onTap: () {
                        showWeatherBottomSheet(context);
                      },
                      child: Container(
                        width: r.h(0.13),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white12.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "-23°",
                                  style: TextStyle(
                                    color: Color(0xFF009DFF),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'digital',
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.wb_sunny,
                                  color: Colors.orangeAccent,
                                  size: 20,
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              "alexandria, eg",
                              style: TextStyle(
                                color: Color(0xFF009DFF),
                                fontSize: 15,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "lat : --",
                              style: TextStyle(
                                color: Color(0xFF009DFF),
                                fontSize: 15,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "long : --",
                              style: TextStyle(
                                color: Color(0xFF009DFF),
                                fontSize: 15,
                                fontFamily: 'digital',
                                fontWeight: FontWeight.bold,
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
      final height = MediaQuery
          .of(context)
          .size
          .height * 0.7;

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
