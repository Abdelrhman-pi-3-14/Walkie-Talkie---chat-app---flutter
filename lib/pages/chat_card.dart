import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isTyping; //  To show typing animation
  final bool showAvatar; //  To show Vee's avatar

  const ChatCard({
    super.key,
    required this.text,
    required this.isUser,
    this.isTyping = false,
    this.showAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 🟣 Vee's avatar (only if not user and showAvatar is true)
        if (!isUser && showAvatar)
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 6),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage("assets/images/vee_icon.png"),
              backgroundColor: Colors.transparent,
            ),
          ),

        // 🟢 Message bubble
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isUser ? Colors.blueAccent : const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isUser
                    ? const Radius.circular(16)
                    : const Radius.circular(0),
                bottomRight: isUser
                    ? const Radius.circular(0)
                    : const Radius.circular(16),
              ),
            ),
            child: isTyping
                ? const _TypingDots() // 🟢 Typing animation
                : Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
          ),
        ),
      ],
    );
  }
}

// 🟣 Typing animation widget (3 bouncing dots)
class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        final progress = _controller.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final offset = (progress + index * 0.2) % 1.0;
            final opacity = offset < 0.5 ? 1.0 - offset * 2 : offset * 2 - 1.0;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Opacity(
                opacity: 1 - opacity.clamp(0.0, 1.0),
                child: const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.white,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
