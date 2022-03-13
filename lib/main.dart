import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Portfolio Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: Text('Crypto Portfolio Tracker'),
      ),
    );
  }
}
