class Message {
  int messageID;
  String text;
  int sentBy;
  int chat;
  DateTime sendTime;

  Message({
    required this.messageID,
    required this.text,
    required this.sentBy,
    required this.chat,
    required this.sendTime
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    messageID: json['messageID'],
    text: json['text'],
    sentBy: json['sentBy'],
    chat: json['chat'],
    sendTime: json['sendTime']
  );

  static List<Message> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Message.fromJson(json)).toList();
  }
}