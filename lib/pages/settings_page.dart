import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E2A47),
        elevation: 0,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF00BBFF),
          ),
        ),
      ),
      body: ListView(
        children: const [
          _SettingsTile(
            icon: Icons.person_outline,
            title: "Profile",
            subtitle: "Edit your name & photo",
          ),

          _SettingsTile(
            icon: Icons.notifications_outlined,
            title: "Notifications",
            subtitle: "Message alerts",
          ),

          _SettingsTile(
            icon: Icons.color_lens_outlined,
            title: "Theme",
            subtitle: "System default",
          ),

          Divider(color: Colors.white24),

          _SettingsTile(
            icon: Icons.lock_outline,
            title: "Privacy",
            subtitle: "Blocked users, data",
          ),

          _SettingsTile(
            icon: Icons.info_outline,
            title: "About",
            subtitle: "App version & info",
          ),

          Divider(color: Colors.white24),

          _SettingsTile(
            icon: Icons.logout,
            title: "Logout",
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool isDestructive;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.redAccent : Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white38),
      onTap: () {
        // TODO: navigate later
      },
    );
  }
}
