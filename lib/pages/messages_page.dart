import 'package:flutter/material.dart';

import '../constants/app_routes.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// MAIN CONTENT
          isEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: const [
                          // messages here
                        ],
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/no_result.png",
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No Messages Found :( ",
                        style: TextStyle(
                          color: Color.fromARGB(103, 172, 170, 170),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),

          /// FLOATING BUTTONS (BOTTOM RIGHT - COLUMN)
          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "fab2",
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.aiChat);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/robot_friend.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 4, 40, 69),

                    heroTag: "fab1",
                    onPressed: () {},
                    child: Image.asset("assets/appIcons/add_message.png"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
