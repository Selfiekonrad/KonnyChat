// get API Request
import 'dart:convert';

import '../models/message_model.dart';
import 'package:http/http.dart' as http;

Future<List<Message>> fetchMessages() async {
  final uri = Uri.parse("http://192.168.0.13:8080/get-all-messages");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);

    return Message.fromJsonList(jsonList);
  } else {
    throw Exception('Failed to load messages');
  }
}