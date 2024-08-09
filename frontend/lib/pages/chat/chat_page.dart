import 'package:flutter/cupertino.dart';
import 'package:frontend/inherited/user_info.dart';
import 'package:frontend/models/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Userinfo.of(context)?.userID;
    print(userInfo);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      navigationBar: cupertinoNavigationBar(),
      child: textMessagesSrollView(),
    );
  }

  CupertinoNavigationBar cupertinoNavigationBar() {
    return const CupertinoNavigationBar(
      backgroundColor: Color(0xFF0C3B2E),
      middle: Text(
        'Anka',
        style: TextStyle(fontSize: 30, color: CupertinoColors.white),
      ),
    );
  }

  Widget textMessagesSrollView() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, _) => singleBubbleMessage()),
          ),
        ),
        SafeArea(
          child: CupertinoTextField(
            placeholder: 'Type a message...',
            suffix: CupertinoButton(
              child: const Icon(CupertinoIcons.paperplane),
              onPressed: () => (),
            ),
          ),
        )
      ],
    );
  }

  Widget singleBubbleMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xFFB1CCC9),
              borderRadius: BorderRadius.circular(20))),
    );
  }
}
