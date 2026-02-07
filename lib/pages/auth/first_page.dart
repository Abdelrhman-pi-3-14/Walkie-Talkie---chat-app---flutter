import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_routes.dart';

class AuthFirstPage extends StatelessWidget {
  const AuthFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 34, 58),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 160),
            child: Text(
              "Welcome To Walkie Talkie Where YOu Can Connect To The Word",
              style: TextStyle(
                color: Color(0xFF009DFF),
                fontSize: 25,
                fontFamily: 'digital',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF009DFF),
                heroTag: "fab1",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.logInPage);
                },
                child: Text(
                  "Log In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            " ------  you don't have an account  ----- ",
            style: TextStyle(color: Color(0xFF009DFF), fontSize: 15),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF009DFF),
                heroTag: "fab1",
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.registerPage);
                },
                child: Text(
                  "register",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
