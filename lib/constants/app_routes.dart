import 'package:flutter/cupertino.dart';
import 'package:walkie_talkie/pages/home/chats/friends_page.dart';
import 'package:walkie_talkie/pages/home/status/write_something_page.dart';
import 'package:walkie_talkie/pages/settings_page.dart';

import '../pages/home/channels/add_channel_page.dart';
import '../pages/home/chats/aiChat/ai_chat_page.dart';
import '../pages/auth/auth_page.dart';
import '../pages/home/main/home_page.dart';

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


  static Map<String, WidgetBuilder> routes() {
    return {
      auth: (context) => const AuthPage(),
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
