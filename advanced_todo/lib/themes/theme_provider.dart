import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:advanced_todo/themes/dark_mode.dart';
import 'package:advanced_todo/themes/light_mode.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightMode);

  void toggleTheme() {
    state = state == lightMode ? darkMode : lightMode;
  }

  bool get isDarkMode => state == darkMode;
}
