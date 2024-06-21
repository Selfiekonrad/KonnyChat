// get API Request
import 'dart:convert';

import '../models/sentMessageInfo_model.dart';
import 'package:http/http.dart' as http;

Future<List<SentMessageInfo>> fetchSentMessageInfo() async {
  final uri = Uri.parse("http://192.168.0.13:8080/get-all-sentMessageInfo");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return SentMessageInfo.fromJsonList(jsonList);
  } else {
    throw Exception('Failed to load SentMessageInfo');
  }
}