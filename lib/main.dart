import 'package:bit_holdings_app/screens/landing_screen.dart';
import 'package:flutter/material.dart';

import 'screens/main_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitHoldings App',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0XFF59B5B2),
        textTheme: TextTheme(
          headline4: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
          headline5: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        buttonTheme: ButtonThemeData(
          minWidth: 300,
          height: 70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      home: LandingScreen(),
    );
  }
}
