import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppThemeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String assetName;

  const AppThemeButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                foregroundColor: WidgetStateProperty.all(Colors.black),
                minimumSize: WidgetStateProperty.all(const Size(130, 100)),
                iconSize: WidgetStateProperty.all<double?>(50)),
            onPressed: onPressed,
            child: Center(
              child: SvgPicture.asset(assetName),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: const TextStyle(color: Colors.white),),
        )
      ],
    );
  }
}
