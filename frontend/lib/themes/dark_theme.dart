// themes/dark_theme.dart

import 'package:flutter/material.dart';

class DarkTheme {
  DarkTheme._();

  static ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    colorScheme: ColorScheme.dark(
      primary: Colors.blueGrey,
      secondary: Colors.lightBlueAccent,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'ProdBaseSolutions',
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.blueGrey),
    ),
    fontFamily: 'ProdBaseSolutions',
  );
}
