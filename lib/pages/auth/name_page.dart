import 'package:flutter/material.dart';
import '../../models/weather/userdata/user_data.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
        _BasePage(
        title: "First Name",
        child: TextField(
          onChanged: (v) => userData.instance.firstName = v,
          style: const TextStyle(color: Colors.white),
          decoration: _inputDecoration("first name "),
        ),
      ),
          const SizedBox(height: 24),
          _BasePage(
            title: "Last Name",
            child: TextField(
              onChanged: (v) => userData.instance.lastName = v,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration("last name "),
            ),
          ),

        ],
      );


  }
}
Widget _BasePage({required String title, required Widget child}) {
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
    hintStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.6)),
    filled: true,
    fillColor: const Color.fromARGB(255, 6, 55, 95),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  );
}
