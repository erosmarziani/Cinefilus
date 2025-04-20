import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static Future<void> initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get darkmode => _prefs.getBool('darkmode') ?? false;

  static set darkmode(bool value) {
    _prefs.setBool('darkmode', value);
  }

  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('darkmode') ?? false;
  }
}
