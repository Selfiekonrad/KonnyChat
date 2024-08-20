import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
  fetchFirstTodo();  // Use 'await' here since fetchFirstTodo is an async function
}

Future<void> fetchFirstTodo() async {
   final httpClient = AppHttpClient();
   final request = AppRequest(url: 'todos/1');
   final response = await httpClient.get(request);
   print(response.rawResponse);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: const Center(
          child: Text('Check the console for fetched data.'),
        ),
      ),
    );
  }
}

class AppRequest {
  final String url;

  AppRequest({required this.url});
}

class AppResponse {
  final bool isValid;
  final Map<String, dynamic>? rawResponse;

  AppResponse.success({required this.rawResponse}) : isValid = true;
  AppResponse.failed() :
      isValid = false,
      rawResponse = null;
}

class AppHttpClient {

  static const String _baseUrl = 'jsonplaceholder.typicode.com';

  final http.Client _client = http.Client();

  Future<AppResponse> get(AppRequest request) async {
    try {
      final uri = Uri.https(_baseUrl, request.url);
      final result = await _client.get(uri);
      final toDecodedJson = jsonDecode(result.body);
      return AppResponse.success(rawResponse: toDecodedJson);
    } catch (e) {
      print(e);
      return AppResponse.failed();
    }
  }

  Future<void> postPosts() async {
    final uri = Uri.https(_baseUrl, 'posts');

    final jsonMap = {
      "userId" : 1,
      "id" : 1,
      "title" : "Der Titel des Posts",
      "body" : "Kurz gefasst: der Inhalt"
    };

    http.Response response = await http.post(
      uri,
      body: json.encode(jsonMap)
    );

    print(response.statusCode);

  }

}























