import 'dart:core';

class Chat {
  int chatID;
  String name;

  Chat({
    required this.chatID,
    required this.name
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    name: json['name'],
    chatID: json['id']
  );

  static List<Chat> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Chat.fromJson(json)).toList();
  }
}