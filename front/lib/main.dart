import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa provider aquí
import 'helpers/preferences.dart';
import 'screens/home_screen.dart';
import 'themes/default_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Preferences.initShared();
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinéfilus',
      theme: DefaultTheme.lightTheme,
      darkTheme: DefaultTheme.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/home',
      routes: {
        '/home': (context) =>
            HomeScreen(onThemeChanged: themeProvider.toggleTheme),
      },
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = Preferences.darkmode ?? false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme(bool value) {
    _isDarkMode = value;
    Preferences.darkmode = _isDarkMode;
    notifyListeners();
  }
}
