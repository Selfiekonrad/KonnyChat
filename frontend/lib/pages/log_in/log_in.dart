import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/navigation_bar.dart';
import 'package:frontend/inherited/user_info.dart';
import 'package:frontend/pages/chats_overview/chats_overview_page.dart';
import 'package:frontend/services/api_service.dart';

class LoginMask extends StatefulWidget {
  const LoginMask({super.key});

  @override
  State<LoginMask> createState() => _LoginMaskState();
}

class _LoginMaskState extends State<LoginMask> {
  late final ApiService _apiService;
  late TextEditingController _userTextController;
  late FocusNode _passwordFocusNode;
  late String _password;
  late String _username;

  @override
  void initState() {
    _password = '';
    _username = '';
    _apiService = ApiService();
    _userTextController = TextEditingController();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: CupertinoPageScaffold(
          navigationBar: appBar('LogIn'),
          backgroundColor: CupertinoColors.secondarySystemBackground,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logInForm(),
                ],
              ),
            ),
          )),
    );
  }

  Widget logInForm() {
    return Column(
      children: [
        usernameField(),
        const SizedBox(height: 8),
        passwordField(),
        const SizedBox(height: 16),
        logInButton()
      ],
    );
  }

  CupertinoTextField usernameField() {
    return CupertinoTextField(
      placeholder: 'Nutzername',
      autofocus: true,
      clearButtonMode: OverlayVisibilityMode.editing,
      controller: _userTextController,
      onChanged: (text) => _username = text,
      onSubmitted: (text) => _passwordFocusNode.requestFocus(),
    );
  }

  CupertinoTextField passwordField() {
    return CupertinoTextField(
      placeholder: 'Passwort',
      clearButtonMode: OverlayVisibilityMode.editing,
      obscureText: true,
      onChanged: (text) => _password = text,
    );
  }

  CupertinoButton logInButton() {
    return CupertinoButton(
        child: const Text('Einloggen'),
        onPressed: () async {
          if ( await fetchLoginStatusBool(_username, _password) ) {
            final userId = await fetchIdByName(_username);

            if (userId != 0) {
              print(userId);
              UserinfoProvider.of(context)?.setUserID(userId);
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (BuildContext context) => ChatsOverview()));
            } else {
              // TODO: DO WHEN USER 0
            }
          } else {
           // TODO: DO WHEN FALSE PASSOWRD OR NO USER
          }
        });
  }

  Future<bool> fetchLoginStatusBool(String name, String password) async {
    try {
      // Call the API to check login status
      bool loginSuccess = await _apiService.fetchLogin(name, password);
      return loginSuccess;
    } catch (error) {
      print('Error during login: $error');
      return false;
    }
  }

  Future<int> fetchIdByName(String name) async {
    try {
      return await _apiService.fetchIdFromUserName(name);
    } catch (error) {
        print('Error during login: $error');
        return 0;
    }
  }
}
