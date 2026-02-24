import 'package:flutter/material.dart';
import '../../models/userdata/user_data.dart';

class EmailPhonePage extends StatelessWidget {
  const EmailPhonePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _basePage(
          title: "Email ",
          child: TextField(
            onChanged: (v) => UserData.instance.email = v,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Email"),

          ),
        ),
        const SizedBox(height: 24),
        _basePage(
          title: " Phone",
          child: TextField(
            onChanged: (v) => UserData.instance.phone = v,
            style: const TextStyle(color: Colors.white),
            decoration: _inputDecoration("Phone"),
          ),
        ),
      ],
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
