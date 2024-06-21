import 'dart:core';

class User {
  int userID;
  String name;
  String password;

  User({
    required this.userID,
    required this.name,
    required this.password
});

  factory User.fromJson(Map<String, dynamic> json) => User(
    userID: json['userID'],
    name: json['name'],
    password: json['password'],
  );

  static List<User> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => User.fromJson(json)).toList();
  }
}