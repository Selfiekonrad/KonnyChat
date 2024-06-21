class Chat {
  int chatID;
  String name;

  Chat({
    required this.chatID,
    required this.name
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    chatID: json['chatID'],
    name: json['name']
  );

  static List<Chat> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Chat.fromJson(json)).toList();
  }
}