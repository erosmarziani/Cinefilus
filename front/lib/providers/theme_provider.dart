import 'package:flutter/material.dart';
import 'package:flutter_application_base/helpers/preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Preferences.darkmode = _isDarkMode;
    notifyListeners();
  }
}
