import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Userinfo extends InheritedWidget {
  Userinfo({
    super.key,
    required super.child,
    required this.userID,
  });

  int? userID;

  static Userinfo? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Userinfo>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class UserinfoProvider extends StatefulWidget {
  final Widget child;

  const UserinfoProvider({super.key, required this.child});

  @override
  _UserinfoProviderState createState() => _UserinfoProviderState();

  // Method to update the userID (exposed for children)
  static _UserinfoProviderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_UserinfoProviderState>();
  }
}

class _UserinfoProviderState extends State<UserinfoProvider> {
  int? _userID;

  void setUserID(int userID) {
    setState(() {
      _userID = userID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Userinfo(
      userID: _userID,
      child: widget.child,
    );
  }
}