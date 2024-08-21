import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/configs/theme/app_theme.dart';
import 'package:frontend/inherited/user_info.dart';
import 'package:frontend/pages/chats_overview/chats_overview_page.dart';
import 'package:frontend/pages/choose_mode/bloc/theme_cubit.dart';
import 'package:frontend/pages/log_in/log_in.dart';
import 'package:frontend/pages/splash/pages/splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserinfoProvider(
      child: MultiBlocProvider(
          providers: [BlocProvider(create: (_) => ThemeCubit())],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) => MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: mode,
                routes: {
                  '/h': (context) => ChatsOverview(),
                  '/': (context) => LoginMask(),
                  '/d': (context) => SplashPage()
                }),
          )),
    );
  }
}
