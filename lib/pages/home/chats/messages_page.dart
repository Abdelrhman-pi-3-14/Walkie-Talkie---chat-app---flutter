import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/app_routes.dart';

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
                Text(
                  "No Messages Found :( ",
                  style: TextStyle(
                    color: Color.fromARGB(103, 135, 133, 133),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 16),

                Image.asset(
                  "assets/images/no_result.png",
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                  heroTag: "fab2",
                  backgroundColor: Color.fromARGB(255, 9, 116, 202),
                  onPressed: () {
            Navigator.pushNamed(context, AppRoutes.aiChat);
            },
              child: Lottie.asset(
                height: 70,
                width: 70,
                "assets/lottie/robot_icon.json",
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
    ),]
    ,
    )
    ,
    );
  }
}
