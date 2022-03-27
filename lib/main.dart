import 'package:bit_holdings_app/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'screens/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyDynamicThemeWidget(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          title: 'BitHoldings App',
          themeMode: themeProvider.themeMode,
          theme: CustomThemeData.lightThemeData,
          darkTheme: CustomThemeData.darkThemeData,
          home: MainView(),
        );
      },
    );
  }
}
