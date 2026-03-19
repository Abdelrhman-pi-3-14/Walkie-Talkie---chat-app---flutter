// presentation/pages/home/main/home_screen/widgets/home_drawer.dart
import 'package:flutter/material.dart';
import '../../../../../../constants/app_routes.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0B1A2A),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("assets/images/male_user.png"),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Abdelrhman Ahmed",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Flutter & Android Developer",
                    style: TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white24),

            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
              leading: const Icon(Icons.settings, color: Colors.white70),
              title: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const Divider(color: Colors.white24),

            const ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
