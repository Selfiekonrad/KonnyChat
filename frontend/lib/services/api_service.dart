import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/chat.dart';
import '../models/user.dart';
import '../models/message.dart';

class ApiService {
  final String _baseUrl = "192.168.0.13:8080";

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
}
