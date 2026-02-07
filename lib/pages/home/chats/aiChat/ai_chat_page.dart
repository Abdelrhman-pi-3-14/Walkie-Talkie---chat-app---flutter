import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/rosponsive_helper.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<_Message> _messages = [];

  void sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.insert(0, _Message(text, true));
      _messages.insert(0, _Message("This is a sample AI reply 🤖", false));
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 34, 58),

      body: Column(
        children: [
          Container(
            height: r.h(0.18),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B2F), // dark walkie-talkie background
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF009DFF),
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 24),

                      Container(
                        width: r.w(0.28),
                        height: r.w(0.20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF009DFF),
                            width: 3,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF28EFEF),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black, width: 6),
                          ),
                          child: Lottie.asset(
                            "assets/lottie/shy_with_bugs.json",
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      /// AI Name
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "V. E. E.",
                            style: TextStyle(
                              color: Color(0xFF009DFF),
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontFamily: "digital",
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Image.asset(
                                "assets/appIcons/arcade_icon.png",
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 8),
                              Image.asset(
                                "assets/appIcons/heart_icon.png",
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 8),

                              Image.asset(
                                "assets/appIcons/sky_icon.png",
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(width: 8),

                              Image.asset(
                                "assets/appIcons/sci_icon.png",
                                height: 30,
                                width: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/smooth_ice_fishing_wallpaper.png",
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.50,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          return _ChatBubble(message: msg);
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onSubmitted: (_) => sendMessage(),
                              decoration: InputDecoration(
                                hintText: "Send a message...",
                                filled: true,
                                fillColor: Colors.white.withValues(alpha: 0.9),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: sendMessage,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ==============================
/// 💬 Chat Bubble Widget
/// ==============================
class _ChatBubble extends StatelessWidget {
  final _Message message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? const Color.fromARGB(255, 11, 118, 209)
              : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isUser ? 20 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 20),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

/// ==============================
/// 🧠 Message Model
/// ==============================
class _Message {
  final String text;
  final bool isUser;

  _Message(this.text, this.isUser);
}
