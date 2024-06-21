import 'dart:core';

class SentMessageInfo {
  int sentMessageInfoID;
  int message;
  int user;
  int chat;

  SentMessageInfo({
    required this.sentMessageInfoID,
    required this.message,
    required this.user,
    required this.chat
  });

  factory SentMessageInfo.fromJson(Map<String, dynamic> json) => SentMessageInfo(
      sentMessageInfoID: json['sentMessageInfoID'],
      message: json['message'],
      user: json['user'],
      chat: json['chat']);

  static List<SentMessageInfo> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SentMessageInfo.fromJson(json)).toList();
  }
}
