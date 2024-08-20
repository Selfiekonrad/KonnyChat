import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ApiService apiService;
  late Future<List<User>> listUsers;

  @override
  void initState() {
    apiService = ApiService();
    listUsers = fetchAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<User>>(
        future: listUsers,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return ListTile(
                      title: Text(user.name), subtitle: Text('ID: ${user.id}'));
                });
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Future<List<User>> fetchAllUsers() async {
    List<User> listOfUsers = [];
    for (int i = 1; i < 2; i++) {
      listOfUsers.add(await ApiService().fetchUserById(i));
    }
    return listOfUsers;
  }
}

class ApiService {
  Future<User> fetchUserById(int id) async {
    var url = Uri.http('192.168.0.13:8080', '/users/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('failed to load user outside class');
    }
  }
}

class User {
  int id;
  String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name} => User(id: id, name: name),
      (_) => throw const FormatException('Failed to loaad user.')
    };
  }
}
