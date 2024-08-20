import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/appbar/navigation_bar.dart';
import 'package:frontend/inherited/user_info.dart';
import 'package:frontend/pages/chats_overview/chats_overview_page.dart';

class LoginMask extends StatefulWidget {
  const LoginMask({super.key});

  @override
  State<LoginMask> createState() => _LoginMaskState();
}

class _LoginMaskState extends State<LoginMask> {
  late TextEditingController _userTextController;
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
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
                  const SizedBox(height: 24),
                  registerForm()
                ],
              ),
            ),
          )),
    );
  }

  Widget registerForm() {
    return Column(
      children: [
        usernameField(),
        const SizedBox(height: 8),
        passwordField(),
        const SizedBox(height: 16),
        registerButton()
      ],
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
      onChanged: (text) => print(text),
      onEditingComplete: () => print('Bearbeitung beendet'),
      onSubmitted: (text) {
        print('Submitted: $text');
        _passwordFocusNode.requestFocus();
      },
    );
  }

  CupertinoTextField passwordField() {
    return CupertinoTextField(
      placeholder: 'Passwort',
      clearButtonMode: OverlayVisibilityMode.editing,
      obscureText: true,
      keyboardType: TextInputType.number,
    );
  }

  CupertinoButton logInButton() {
    return CupertinoButton(
        child: const Text('Einloggen'),
        onPressed: () {
          _userTextController.selection = TextSelection(
              baseOffset: 0, extentOffset: _userTextController.text.length);
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (BuildContext context) => Userinfo(child: ChatsOverview(), userID: 2)));
        });
  }

  CupertinoButton registerButton() {
    return CupertinoButton(
        child: const Text('Registieren'),
        onPressed: () {
          _userTextController.selection = TextSelection(
              baseOffset: 0, extentOffset: _userTextController.text.length);
        });
  }
}
