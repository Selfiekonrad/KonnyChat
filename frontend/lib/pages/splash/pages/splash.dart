import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/chats_overview/chats_overview_page.dart';
import 'package:frontend/pages/choose_mode/pages/choose_mode.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('KonnyChat'),
      ),
    );
  }

  Future<void> redirect () async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (BuildContext context) => ChooseModePage()));
  }
}
