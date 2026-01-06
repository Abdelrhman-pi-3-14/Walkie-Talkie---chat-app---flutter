
import 'package:flutter/cupertino.dart';

import '../pages/ai_chat_page.dart';
import '../pages/home_page.dart';

class AppRoutes {
  static const String authWarpper = '/';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String help = '/help';
  static const String chat = '/chat';
  static const String auth = '/auth';
  static const String signup = '/signup';
  static const String aiChat = '/aichat';

  static Map<String, WidgetBuilder> routes() {
    return {

      home: (context) => HomePage(),
      aiChat : (context) => AiChatPage()
    /* chat: (context) =>  ChatPage(),
      auth: (context) => const AuthPage(),
      signup: (context) => const SignInPage(),*/
    };
  }
}
