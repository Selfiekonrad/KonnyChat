import 'package:flutter/cupertino.dart';

class SingleChatWidget extends StatelessWidget {
  final String name;
  final String message;

  const SingleChatWidget(
      {super.key, required this.name, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/chat'),
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
          decoration: BoxDecoration(
              color: const Color(0xFFB1CCC9),
              borderRadius: BorderRadius.circular(20))),
    );
  }

  Widget userInformation() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 7),
            Text(
              message,
              style: const TextStyle(color: CupertinoColors.secondaryLabel),
            )
          ],
        ));
  }

  Widget profilePicture() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }
}
