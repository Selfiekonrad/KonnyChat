import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../chat/pages/new_chat_page.dart';

class SingleChatWidget extends StatelessWidget {
  final User user;
  final String lastMessage;

  const SingleChatWidget(
      {super.key, required this.lastMessage, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => NewChatPage(textingUser: user))),
      child: Stack(
        children: [
          chatBackground(),
          Row(
            children: [profilePicture(), userInformation()],
          ),
        ],
      ),
    );
  }

  Widget chatBackground() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget lineSeperator() {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Container(
          width: double.infinity,
          height: 2,
          decoration: BoxDecoration(
              color: const Color(0xFFB1CCC9),
              borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget userInformation() {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                user.name,
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 7),
              Text(
                lastMessage,
                style: const TextStyle(color: Colors.black12),
              ),
              const SizedBox(height: 8),
              lineSeperator()
            ],
          )),
    );
  }

  Widget profilePicture() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
