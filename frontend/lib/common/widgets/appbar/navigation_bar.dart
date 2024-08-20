import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CupertinoNavigationBar appBar(String barText) {
  return CupertinoNavigationBar(
      backgroundColor: const Color(0xFF0C3B2E),
      middle: Text(barText,
          style: const TextStyle(fontSize: 30, color: CupertinoColors.white)));
}
