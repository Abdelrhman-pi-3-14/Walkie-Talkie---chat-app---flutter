import 'package:flutter/cupertino.dart';

import '../pages/ai_chat_page.dart';
import '../pages/auth/auth_page.dart';
import '../pages/home/home_page.dart';

class AppRoutes {
  static const String authWarpper = '/';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String help = '/help';
  static const String chat = '/chat';
  static const String auth = '/auth';
  static const String aiChat = '/aiChat';

  static Map<String, WidgetBuilder> routes() {
    return {
      auth: (context) => const AuthPage(),
      home: (context) => const HomePage(),
      aiChat: (context) => const AiChatPage(),
      //chat: (context) =>  ChatPage(),
    };
  }
}
