import 'package:flutter/material.dart';
import 'package:walkie_talkie/pages/status_page.dart';
import '../constants/rosponsive_helper.dart';
import 'channels_page.dart';
import 'messages_page.dart';

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

  bool isWeatherContentThere = false;

  TextEditingController? _controller;

  bool hasWeatherData = true;

  @override
  void dispose() {
    _pageController.dispose();
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
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 4, 40, 69),
              ),
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
            height: r.h(0.16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 👤 Profile pic
                Builder(
                  builder: (context) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
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

                /// 🌤 Weather Info
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
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
                            "Online Friends : 70 ",
                            style: TextStyle(
                              color: Color(0xFF00BBFF),
                              fontSize: 15,
                              fontFamily: 'digital',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 24),

                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                child: Container(
                                  height: r.h(0.6),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 4, 40, 69),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      /// 🌤 MAIN ICON
                                      Image.asset(
                                        "assets/appIcons/find_weather_icon.png",
                                        height: 180,
                                      ),

                                      const SizedBox(height: 16),

                                      /// 🔀 CONDITIONAL UI
                                      if (!hasWeatherData) ...[
                                        /// 📝 NO DATA TEXT
                                        const Text(
                                          "Finding Weather...",
                                          style: TextStyle(
                                            color: Color(0xFF00BBFF),
                                            fontSize: 22,
                                            fontFamily: 'digital',
                                          ),
                                        ),
                                      ] else ...[
                                        /// 🌦 FORECAST LIST
                                        SizedBox(
                                          height: 150,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: 7,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: 110,
                                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(255, 6, 50, 87),
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/appIcons/weather_icon.png",
                                                      height: 50,
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const Text(
                                                      "23°C",
                                                      style: TextStyle(
                                                        color: Color(0xFF00BBFF),
                                                        fontSize: 20,
                                                        fontFamily: 'digital',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],

                                      const SizedBox(height: 24),

                                      /// 🔍 SEARCH SECTION (Always Visible)
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
                                                hintText: "Enter Country , City",
                                                hintStyle: const TextStyle(
                                                  color: Color(0xFF00BBFF),
                                                  fontFamily: 'digital',
                                                ),
                                                filled: true,
                                                fillColor: const Color.fromARGB(255, 4, 40, 69),
                                                contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 16,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFF00BBFF),
                                                    width: 2,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFF00FFFF),
                                                    width: 2.5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 12),

                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                hasWeatherData = true; // بعد نجاح البحث
                                              });
                                            },
                                            borderRadius: BorderRadius.circular(16),
                                            child: Container(
                                              height: 56,
                                              width: 56,
                                              padding: const EdgeInsets.all(14),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 6, 50, 87),
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                              child: Image.asset(
                                                "assets/appIcons/search_icon.png",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )


                                ),
                              );
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Row(
                              children: [
                                Text(
                                  "32°",
                                  style: TextStyle(
                                    color: Color(0xFF009DFF),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'digital',
                                  ),
                                ),

                                SizedBox(width: 16),

                                Icon(
                                  Icons.wb_sunny,
                                  color: Colors.orangeAccent,
                                  size: 28,
                                ),
                              ],
                            ),
                            Text(
                              "Cairo, Egypt",
                              style: TextStyle(
                                color: Color(0xFF009DFF),
                                fontSize: 16,
                                fontFamily: 'digital',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
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

                  const SizedBox(height: 24),

                  /// ⭕ Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(items.length, (index) {
                      final bool isSelected = index == _currentIndex;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: isSelected ? 120 : 10,
                        height: isSelected ? 50 : 10,
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
                                  height: 100,
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
