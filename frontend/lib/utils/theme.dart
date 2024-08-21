// utils/theme.dart
import 'package:flutter/material.dart';
import '../themes/light_theme.dart';
import '../themes/dark_theme.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = LightTheme.theme;
  static final ThemeData darkTheme = DarkTheme.theme;
}
