// get API Request

import 'dart:convert';

import '../models/chat_model.dart';
import 'package:http/http.dart' as http;

Future<List<Chat>> fetchChats() async {
  final uri = Uri.parse("http://192.168.0.13:8080/get-all-chats");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return Chat.fromJsonList(jsonList);
  } else {
    throw Exception('Failed to load chats');
  }
}