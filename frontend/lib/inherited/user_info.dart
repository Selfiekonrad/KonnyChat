import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Userinfo extends InheritedWidget {
  const Userinfo({
    super.key,
    required super.child,
    required this.userID,
  });

  final int userID;

  static Userinfo? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Userinfo>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
