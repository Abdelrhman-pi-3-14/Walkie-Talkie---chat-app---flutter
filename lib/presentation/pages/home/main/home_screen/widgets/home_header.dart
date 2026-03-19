// presentation/pages/home/main/home_screen/widgets/home_header.dart
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import '../../../../../../constants/rosponsive_helper.dart';

class HomeHeader extends StatelessWidget {
  final Responsive r;
  final double sheetProgress;
  final VoidCallback onTapRadio;
  final VoidCallback onTapWeather;

  const HomeHeader({
    super.key,
    required this.r,
    required this.sheetProgress,
    required this.onTapRadio,
    required this.onTapWeather,
  });

  @override
  Widget build(BuildContext context) {
    final cardOpacity = (1 - sheetProgress * 0.9).clamp(0.0, 1.0);
    final cardScale = lerpDouble(1.0, 0.85, sheetProgress)!;

    return Container(
      height: r.h(0.30),
      padding: EdgeInsets.symmetric(
        horizontal: r.paddingMedium,
        vertical: r.paddingMedium,
      ),
      child: Column(
        children: [
          SizedBox(height: r.h(0.03)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// LEFT COLUMN
              Opacity(
                opacity: cardOpacity,
                child: Transform.scale(
                  scale: cardScale,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      _profileCard(context),

                      SizedBox(height: r.h(0.02)),

                      _radioCard(),
                    ],
                  ),
                ),
              ),

SizedBox(
  width: r.w(.02),
),
              /// WEATHER
              Opacity(
                opacity: cardOpacity,
                child: Transform.scale(
                  scale: cardScale,
                  child: _weatherCard(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _profileCard(BuildContext context) {
    return InkWell(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Container(
        height: r.h(0.10),
        width: r.w(0.60),
        padding: EdgeInsets.all(r.paddingSmall),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(r.w(0.04)),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(r.w(0.04)),
              child: Image.asset(
                "assets/images/male_user.png",
                height: r.h(0.07),
                width: r.h(0.07),
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: r.w(0.03)),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Status : Connected",
                  style: TextStyle(
                    color: const Color(0xFF00BBFF),
                    fontSize: r.w(0.04),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'digital',
                  ),
                ),
                SizedBox(height: r.h(0.01)),
                Text(
                  "Online Friends : 70",
                  style: TextStyle(
                    color: const Color(0xFF00BBFF),
                    fontSize: r.w(0.035),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'digital',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _radioCard() {
    return GestureDetector(
      onTap: onTapRadio,
      child: Container(
        width: r.w(0.60),
        padding: EdgeInsets.all(r.paddingSmall),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(r.w(0.04)),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            SizedBox(
              width: r.w(0.08),
              child: Image.asset("assets/appIcons/radio_icon.png"),
            ),
            SizedBox(width: r.w(0.04)),
            Text(
              "FM Radio",
              style: TextStyle(
                color: const Color(0xFF00BBFF),
                fontSize: r.w(0.04),
                fontWeight: FontWeight.bold,
                fontFamily: 'digital',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _weatherCard() {
    return GestureDetector(
      onTap: onTapWeather,
      child: Container(
        width: r.w(0.30),
        height: r.h(0.2),
        padding: EdgeInsets.all(r.paddingSmall),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(r.w(0.04)),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "-23°",
                  style: TextStyle(
                    fontSize: r.w(0.07),
                    color: const Color(0xFF009DFF),
                    fontFamily: 'digital',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: r.w(0.02)),
                Icon(
                  Icons.wb_sunny,
                  size: r.w(0.05),
                  color: Colors.orangeAccent,
                ),
              ],
            ),
            SizedBox(height: r.h(0.02)),
            Text(
              "alexandria, eg",
              style: TextStyle(
                fontSize: r.w(0.035),
                color: const Color(0xFF009DFF),
                fontFamily: 'digital',
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}