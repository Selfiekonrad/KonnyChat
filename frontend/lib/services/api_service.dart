import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/chat.dart';
import '../models/user.dart';
import '../models/message.dart';

class ApiService {
  final String _baseUrl = "192.168.0.30:8081";

  Future<User> fetchUserById(int id) async {
    var url = Uri.http(_baseUrl, '/users/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load all users inside Apiservice');
    }
  }

  Future<List<User>> fetchAllUsers() async {
    var url = Uri.http(_baseUrl, '/users');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('failed to load all users inside Apiservice');
    }
  }

  Future<List<User>> fetchAllUsersWithoutPersonId(int id) async {
    var url = Uri.http(_baseUrl, '/users/without/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('failed to load all users inside Apiservice');
    }
  }

  Future<Chat> fetchChatByPersonOneIdAndPersonTwoId(int personOneId, int personTwoId) async {
    var url = Uri.http(_baseUrl, '/chat/$personOneId/$personTwoId');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return Chat.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load chat data. Status code: ${response.statusCode}');
    }
  }

  Future<List<Message>> fetchAllMessagesFromChatId(int id) async {
    var url = Uri.http(_baseUrl, 'messages/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('failed to load all users inside Apiservice');
    }
  }

  Stream<List<Message>> fetchAllMessagesFromChatIdAsStream(int chatId) async* {
    while (true) {
      try {
        yield await fetchAllMessagesFromChatId(chatId);
      } catch (e) {
        print('Error fetching messages as Stream: $e');
        yield [];
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<bool> fetchLogin(String name, String password) async {
    var url = Uri.http(_baseUrl, '/users/login/$name/$password');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load login bool. status code: ${response.statusCode}');
    }
  }

  Future<int> fetchIdFromUserName(String name) async {
    var url = Uri.http(_baseUrl, '/users/getUserIdFromName/$name');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load id from name. status code: ${response.statusCode}');
    }
  }

  Future<int> postMessage(Map<String, dynamic> json) async {
    var url = Uri.http(_baseUrl, '/messages');

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(json),
    );

    return response.statusCode;
  }

}
