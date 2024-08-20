import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/assets/app_images.dart';
import 'package:frontend/core/assets/app_vectors.dart';
import 'package:frontend/pages/choose_mode/bloc/theme_cubit.dart';
import 'package:frontend/pages/log_in/log_in.dart';

import '../../../common/widgets/button/app_theme_button.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppImages.choose_mode_backround,
          fit: BoxFit.cover,
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      'what mode would you like to use?',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppThemeButton(
                        onPressed: () {
                          context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(builder: (BuildContext context) => LoginMask()));
                        },
                        title: 'darkmode',
                        assetName: AppVectors.moon,
                      ),
                      AppThemeButton(
                          onPressed: () {
                            context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(builder: (BuildContext context) => LoginMask()));
                          },
                          title: 'lightmode',
                          assetName: AppVectors.sun)
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Text(
                    'you can change it in the setting later',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const Spacer(flex: 1)
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
