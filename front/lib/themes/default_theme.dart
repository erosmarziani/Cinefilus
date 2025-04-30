import 'package:flutter/material.dart';

class DefaultTheme {
  static const Color primaryDark = Color(0xFF00796B);
  static const Color secondary = Color(0xFF8E24AA);
  static const Color formElementsColor = Color(0xFF4CAF50);
  static const Color backgroundLight = Color(0xFFF0F4F1);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryDark,
      secondary: secondary,
      background: backgroundLight,
    ),
    cardColor: Colors.white,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFFF8F8F8),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF3F3F3),
      selectedItemColor: primaryDark,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(color: primaryDark),
      showUnselectedLabels: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: primaryDark,
      textColor: Colors.black87,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      floatingLabelStyle: const TextStyle(color: formElementsColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: formElementsColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: formElementsColor, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
    ),
    cardColor: const Color(0xFF212121),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF121212),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1C1C1C),
      selectedItemColor: Color(0xFF4CAF50),
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(color: Color(0xFF4CAF50)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: Colors.white,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(iconColor: primaryDark),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: const TextStyle(color: formElementsColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: formElementsColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: formElementsColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
