// providers/theme_provider.dart
import 'package:flutter/material.dart';
import '../utils/theme.dart'; // Make sure to adjust the path to your actual theme.dart file

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;
  String
      themeString; // This can be "light" or "dark", based on user's preference

  ThemeProvider(this.themeString)
      : _themeData =
            (themeString == 'dark') ? AppTheme.darkTheme : AppTheme.lightTheme;

  ThemeData get themeData => _themeData;

  void setTheme(String theme) {
    themeString = theme;
    if (themeString == 'dark') {
      _themeData = AppTheme.darkTheme;
    } else {
      _themeData = AppTheme.lightTheme;
    }
    notifyListeners(); // This will trigger the rebuild of UI parts that use theme
  }
}
