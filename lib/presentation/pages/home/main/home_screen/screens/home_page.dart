// presentation/pages/home/main/home_screen/screens/home_page.dart

import 'package:flutter/material.dart';
import 'package:walkie_talkie/presentation/pages/home/main/miniApps/radio/screens/radio_sheet.dart';
import 'package:walkie_talkie/presentation/pages/home/main/miniApps/weather/screens/weather_sheet.dart';


import '../../../../../../constants/rosponsive_helper.dart';
import '../../../../../../data/models/weather/current_weather.dart';

import '../widgets/home_header.dart';
import '../widgets/home_drawer.dart';
import '../widgets/draggable_sheet.dart';


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

  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double _sheetExtent = 0.45;

  @override
  void initState() {
    super.initState();

    _sheetController.addListener(() {
      try {
        final s = _sheetController.size;
        if (s != _sheetExtent) {
          setState(() => _sheetExtent = s);
        }
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    _sheetController.dispose();
    super.dispose();
  }

  double _mapSheetTo01() {
    // Map sheet extent (0.25..0.95) -> (0..1)
    const min = 0.25;
    const max = 0.95;
    return ((_sheetExtent - min) / (max - min)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final progress = _mapSheetTo01();

    return Scaffold(
      backgroundColor: const Color(0xFF042845),
      drawer: const HomeDrawer(),
      body: Stack(
        children: [
          // BLUE HEADER
          HomeHeader(
            r: r,
            sheetProgress: progress,
            onTapRadio: () => _openRadioSheet(context),
            onTapWeather: () => showWeatherBottomSheet(context),
          ),

          // DRAGGABLE WHITE SHEET
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 1,
            snap: true,
            snapSizes: const [0.7,1],
            builder: (context, scrollController) {
              return DraggableSheetContent(
                r: r,
                scrollController: scrollController,
                pageController: _pageController,
                items: items,
                currentIndex: _currentIndex,
                onPageChanged: (index) => setState(() => _currentIndex = index),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openRadioSheet(BuildContext context) {
    final r = Responsive(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(r.w(0.05)),
          child: Container(
            height: r.h(0.7),
            padding: EdgeInsets.all(r.paddingMedium),
            decoration: BoxDecoration(
              color: const Color(0xFF042845),
              borderRadius: BorderRadius.circular(r.w(0.05)),
            ),
            child: const RadioBottomSheetContent(),
          ),
        );
      },
    );
  }
}

// presentation/pages/home/main/home_screen/widgets/weather_bottom_sheet.dart


void showWeatherBottomSheet(BuildContext context) {
  final r = Responsive(context);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(r.w(0.05)),
        child: Container(
          height: r.h(0.7),
          padding: EdgeInsets.all(r.paddingMedium),
          decoration: BoxDecoration(
            color: const Color(0xFF042845),
            borderRadius: BorderRadius.circular(r.w(0.05)),
          ),
          child: WeatherBottomSheetContent(),
        ),
      );
    },
  );
}