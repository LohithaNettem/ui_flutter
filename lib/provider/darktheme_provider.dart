import 'package:flutter/material.dart';
import 'package:ui_flutter/darkthemepreferences.dart';

class DarkThemeProvider extends ChangeNotifier {
  DarkThemePreferences obj = DarkThemePreferences();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    obj.setDarkTheme(value);
    notifyListeners();
  }
}
