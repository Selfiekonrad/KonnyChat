// get API Request
import 'dart:convert';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUsers() async {
  final uri = Uri.parse("http://192.168.0.13:8080/get-all-users");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    return User.fromJsonList(jsonList);
  } else {
    throw Exception('Failed to load users');
  }
}


// POST Api Request
Future<User> createUser(String name, String password) async {
  Map<String, dynamic> request = {
    'name' : name,
    'password' : password
  };
  final uri = Uri.parse("http://192.168.0.13:8080/add");
  final response = await http.post(uri, body: request);

  if (response.statusCode == 201) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('failed to load user');
  }
}