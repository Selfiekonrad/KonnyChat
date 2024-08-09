import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'single_chat_widget.dart';

class ChatsOverview extends StatefulWidget {
  const ChatsOverview({super.key});

  @override
  State<ChatsOverview> createState() => _ChatsOverviewState();
}

class _ChatsOverviewState extends State<ChatsOverview> {
  final names = {'Konrad', 'Ania', 'Maja', 'Jonathan'};
  final messages = {'Spierdalaj', 'hey', 'pizda', 'ich lieve dich'};

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: cupertinoNavigationBar(), child: chatOverview());
  }

  CupertinoNavigationBar cupertinoNavigationBar() {
    return const CupertinoNavigationBar(
      backgroundColor: Color(0xFF0C3B2E),
      middle: Text(
        'Chats',
        style: TextStyle(fontSize: 30, color: CupertinoColors.white),
      ),
    );
  }

  Widget chatOverview() {
    return ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) =>

            SingleChatWidget(
            name: names.elementAt(index), message: messages.elementAt(index),));
  }
}



