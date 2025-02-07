import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _prefs;

  static const _keyDarkMode = 'darkMode';

  // Inicializa SharedPreferences
  static Future initShared() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Obtiene el estado de DarkMode
  static bool get darkmode {
    return _prefs?.getBool(_keyDarkMode) ?? false;  // Devuelve false si no hay valor guardado
  }

  // Guarda el estado de DarkMode
  static set darkmode(bool value) {
    _prefs?.setBool(_keyDarkMode, value);
  }
}
