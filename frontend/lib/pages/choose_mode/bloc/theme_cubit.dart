import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {

  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    final themeString = json['theme'] as String;
    return ThemeMode.values.firstWhere(
          (e) => e.toString() == themeString,
      orElse: () => ThemeMode.light,
    );
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {'theme': state.toString()};
  }
  
}