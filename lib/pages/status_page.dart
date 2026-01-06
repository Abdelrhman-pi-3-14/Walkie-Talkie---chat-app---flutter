import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<MaterialColor> items = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(decoration: const BoxDecoration(color: Colors.white)),

          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Center(
                      child: Text(items[index].toString().toUpperCase()),
                    ),
                  ),
                ),

              );
            },
          ),
          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: "fab2",
                  onPressed: () {
                    // Navigator.pushNamed(context, AppRoutes.AiChat);
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
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 0, 157, 255),

                    heroTag: "fab1",
                    onPressed: () {
                    },
                    child: Image.asset(
                      "assets/images/camera.png",
                    ),
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
