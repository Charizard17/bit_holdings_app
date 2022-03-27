import 'package:flutter/material.dart';
import '../services/flutterfire.dart';

FlutterFire _flutterFire = FlutterFire();

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    _flutterFire.addSettings(isOn.toString());
    notifyListeners();
  }
}

// Color(0XFF59B5B2)

class CustomThemeData {
  // LIGHT THEME DATA
  static final lightThemeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    primaryColorLight: Color.fromARGB(183, 186, 186, 186),
    focusColor: Color(0XFF59B5B2),
    hintColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(179, 203, 203, 203),
    ),
    fontFamily: 'Texturina',
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 25,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
    buttonTheme: ButtonThemeData(
      minWidth: double.infinity,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );

  // DARK THEME DATA
  static final darkThemeData = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.black,
    primaryColorLight: Color.fromARGB(179, 85, 85, 85),
    focusColor: Color(0XFF59B5B2),
    hintColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 65, 65, 65),
    ),
    fontFamily: 'Oxygen',
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 25,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
    ),
    buttonTheme: ButtonThemeData(
      minWidth: double.infinity,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}
