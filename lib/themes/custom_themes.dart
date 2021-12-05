import 'package:flutter/material.dart';
import 'package:miaged/tools/constant.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class CustomThemes {
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      appBarTheme: const AppBarTheme(color: Color(colorSchemeBarLight)),
      cardColor: const Color(colorSchemeItemLight),
      colorScheme: const ColorScheme.light());

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
      appBarTheme: const AppBarTheme(color: Color(colorSchemeBarDark)),
      primaryColor: Colors.white,
      cardColor: const Color(colorSchemeItemDark),
      // bottomAppBarColor: Color(colorSchemeBarDark),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white10,
      ),
      colorScheme: const ColorScheme.dark());
}
