class Message {
  final int id;
  final int sender;
  final int receiver;
  final int chatId;
  final String messageText;
  final String timeSent;

  Message(
      {required this.id,
      required this.sender,
      required this.receiver,
      required this.chatId,
      required this.messageText,
      required this.timeSent});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        sender: json['sender'],
        receiver: json['receiver'],
        chatId: json['chatId'],
        messageText: json['messageText'],
        timeSent: json['timeSent']);
  }
}


