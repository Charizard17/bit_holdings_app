import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/main_view.dart';
import 'screens/sign_in_screen.dart';
import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyDynamicThemeWidget(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeProvider>(
                create: (_) => ThemeProvider()),
            ChangeNotifierProvider<LocaleProvider>(
                create: (_) => LocaleProvider()),
          ],
          child: MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('Settings')
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (!streamSnapshot.hasData) {
          return Container(
            color: CustomThemeData.darkThemeData.focusColor,
            child: Center(
              child: Image.asset(
                'assets/images/bitholdings_256.png',
                width: 150,
                height: 150,
              ),
            ),
          );
        }

        if (streamSnapshot.data!.docs.length != 0) {
          final isDarkMode = streamSnapshot.data!.docs
              .firstWhere((document) => document.id == 'ThemeMode');

          if (isDarkMode.get('isDarkMode') == 'true') {
            themeProvider.themeMode = ThemeMode.dark;
          } else if (isDarkMode.get('isDarkMode') == 'false') {
            themeProvider.themeMode = ThemeMode.light;
          }
        }

        return MaterialApp(
          title: 'Bit Holdings',
          themeMode: themeProvider.themeMode,
          theme: CustomThemeData.lightThemeData,
          darkTheme: CustomThemeData.darkThemeData,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainView();
              } else {
                return SignInScreen();
              }
            },
          ),
          supportedLocales: L10n.all,
          locale: localeProvider.locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale!.languageCode &&
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      },
    );
  }
}
