import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'sign_in_screen.dart';
import 'delete_account_screen.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';
import '../services/flutterfire.dart';

FlutterFire _flutterFire = FlutterFire();

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String languageDropdownValue = 'English';
  String currencyDropdownValue = 'USD';

  @override
  Widget build(BuildContext context) {
    final appLocalizationsContext = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                appLocalizationsContext.settings,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Divider(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      thickness: 1,
                    ),
                    SwitchListTile(
                      title: Text(
                        themeProvider.isDarkMode == true
                            ? appLocalizationsContext.darkMode
                            : appLocalizationsContext.lightMode,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                      ),
                      secondary: themeProvider.isDarkMode == true
                          ? Icon(
                              Icons.dark_mode_rounded,
                              color: Theme.of(context).focusColor,
                            )
                          : Icon(
                              Icons.light_mode,
                              color: Colors.amber,
                            ),
                      activeColor: Theme.of(context).focusColor,
                      inactiveThumbColor: Colors.amber,
                      inactiveTrackColor: Colors.amber.withOpacity(0.7),
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(value);
                      },
                    ),
                    Divider(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizationsContext.language,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        DropdownButton<String>(
                          value: languageDropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .fontSize,
                          ),
                          dropdownColor: Theme.of(context).primaryColorLight,
                          underline: Container(
                            height: 1,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              languageDropdownValue = newValue!;
                            });
                          },
                          items: <String>[
                            'English',
                            'Deutsch',
                            'Türkçe',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              onTap: () {
                                final provider = Provider.of<LocaleProvider>(
                                    context,
                                    listen: false);

                                var locale = Locale('en', 'US');
                                if (value == 'English') {
                                  locale = Locale('en', 'US');
                                }
                                if (value == 'Deutsch') {
                                  locale = Locale('de', 'DE');
                                }
                                if (value == 'Türkçe') {
                                  locale = Locale('tr', 'TR');
                                }
                                provider.setLocale(locale);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      thickness: 1,
                    ),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appLocalizationsContext.currency,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            DropdownButton<String>(
                              value: currencyDropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              style: Theme.of(context).textTheme.bodyMedium,
                              dropdownColor:
                                  Theme.of(context).primaryColorLight,
                              underline: Container(
                                height: 1,
                              ),
                              onChanged: null,
                              // onChanged: (String? newValue) {
                              //   setState(() {
                              //     currencyDropdownValue = newValue!;
                              //   });
                              // },
                              items: <String>[
                                'USD',
                                'EUR',
                                'GBP'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 15,
                          right: 0,
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(30 / 360),
                            child: Container(
                              color:
                                  Theme.of(context).errorColor.withOpacity(0.5),
                              child: Text(
                                'Coming soon',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: MaterialButton(
                  color: Theme.of(context).errorColor,
                  child: Text(
                    appLocalizationsContext.deleteAccount,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () async {
                    // await _flutterFire.deleteUser();
                    // bool shouldNavigate = await _flutterFire.deleteUser();
                    // if (shouldNavigate == true) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DeleteAccountScreen(),
                      ),
                    );
                    // }
                  },
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: MaterialButton(
                  color: Theme.of(context).focusColor,
                  child: Text(
                    appLocalizationsContext.signOut,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  onPressed: () async {
                    bool shouldNavigate = await _flutterFire.signOut();
                    if (shouldNavigate) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SignInScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
