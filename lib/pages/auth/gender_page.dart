import 'package:flutter/material.dart';

import '../../models/userdata/user_data.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String selected = UserData.instance.gender;

  @override
  Widget build(BuildContext context) {
    return _basePage(
      title: "Select Gender",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _genderItem("male", "assets/images/male_user.png"),
          _genderItem("female", "assets/images/female_user.png"),
        ],
      ),
    );
  }

  Widget _genderItem(String value, String asset) {
    final isSelected = selected == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = value;
          UserData.instance.gender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.lightBlueAccent : Colors.transparent,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(asset, width: 120),
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

/*
InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.6)),
    filled: true,
    fillColor: const Color.fromARGB(255, 6, 55, 95),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  );
}
*/

