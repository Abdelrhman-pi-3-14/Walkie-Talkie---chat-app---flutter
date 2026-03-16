// constants/app_routes.dart
import 'package:flutter/cupertino.dart';
import 'package:walkie_talkie/presentation/pages/auth/first_page.dart';
import 'package:walkie_talkie/presentation/pages/home/chats/friends_page.dart';
import 'package:walkie_talkie/presentation/pages/home/status/write_something_page.dart';
import 'package:walkie_talkie/presentation/pages/settings_page.dart';

import '../presentation/pages/auth/log_in_page.dart';
import '../presentation/pages/home/channels/add_channel_page.dart';
import '../presentation/pages/home/chats/aiChat/ai_chat_page.dart';
import '../presentation/pages/auth/auth_page.dart';
import '../presentation/pages/home/main/home_page.dart';

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
  static const String writeSomething = '/writeSomething';
  static const String friendsPage = '/friendsPage';
  static const String addChannelPage = '/addChannel';
  static const String registerPage = "/register";
  static const String logInPage = "/logIn";



  static Map<String, WidgetBuilder> routes() {
    return {
      auth: (context) => const AuthFirstPage(),
      registerPage : (context) => const AuthPage(),
      logInPage : (context) => const LogInPage(),
      home: (context) => const HomePage(),
      aiChat: (context) => const AiChatPage(),
      settings : (context) => const SettingsPage(),
      writeSomething : (context) => const WriteSomethingPage(),
      friendsPage : (context) => const FriendsPage(),
      addChannelPage : (context) => const AddChannelPage(),

      //chat: (context) =>  ChatPage(),
    };
  }
}
