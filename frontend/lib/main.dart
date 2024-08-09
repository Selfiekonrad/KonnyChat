import 'package:flutter/cupertino.dart';
import 'package:frontend/inherited/user_info.dart';
import 'package:frontend/pages/chat/chat_page.dart';
import 'package:frontend/pages/log_in/chats_overview_page.dart';

void main() {
  runApp(Userinfo(userID: 1, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(initialRoute: '/', routes: {
      '/': (context) => ChatsOverview(),
      '/chat': (context) => ChatPage(),
    });
  }
}
