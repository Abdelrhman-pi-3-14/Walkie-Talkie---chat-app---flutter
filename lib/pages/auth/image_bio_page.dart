import 'package:flutter/material.dart';
import '../../models/userdata/user_data.dart';

class ImageBioPage extends StatelessWidget {
  const ImageBioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gender = UserData.instance.gender;

    return _basePage(
      title: "Profile",
      child: Column(
        children: [
          Image.asset(
            gender == "female"
                ? "assets/images/female_user.png"
                : "assets/images/male_user.png",
            width: 120,
          ),
          const SizedBox(height: 20),
          TextField(
            maxLines: 5,
            maxLength: 250,
            onChanged: (v) => UserData.instance.bio = v,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Write your bio (max 250 chars)"),
          ),
        ],
      ),
    );
  }
}
Widget _basePage({required String title, required Widget child}) {
  return Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.lightBlueAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'digital',
          ),
        ),
        const SizedBox(height: 24),
        child,
      ],
    ),
  );
}

InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.lightBlueAccent.withValues(alpha: 0.6)),
    filled: true,
    fillColor: const Color.fromARGB(255, 6, 55, 95),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  );
}
