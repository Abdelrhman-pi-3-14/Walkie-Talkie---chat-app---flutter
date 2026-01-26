import 'package:flutter/material.dart';

class WriteSomethingPage extends StatefulWidget {
  const WriteSomethingPage({super.key});

  @override
  State<WriteSomethingPage> createState() => _WriteSomethingPageState();
}

class _WriteSomethingPageState extends State<WriteSomethingPage> {
  final TextEditingController _controller = TextEditingController();

  Color selectedColor = Colors.green; // default color

  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(24), child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 25,
                ),
              ),

              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: colors.length,
                separatorBuilder: (_, __) => const SizedBox(width: 24),
                itemBuilder: (context, index) {
                  final color = colors[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withValues(
                            alpha: selectedColor == color ? 1 : 0.4,
                          ),
                          width: selectedColor == color ? 3 : 1,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Write your status...",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 28),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 6, 50, 87),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      "assets/appIcons/send_icon.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
