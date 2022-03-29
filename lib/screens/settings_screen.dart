import 'package:bit_holdings_app/screens/delete_account_screen.dart';
import 'package:bit_holdings_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String appereanceDropdownValue = 'Dark Mode';
  String currencyDropdownValue = 'USD';
  @override
  Widget build(BuildContext context) {
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
                'Settings',
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
                            ? 'Dark Mode'
                            : 'Light Mode',
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
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Language',
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
                              dropdownColor:
                                  Theme.of(context).primaryColorLight,
                              underline: Container(
                                height: 1,
                              ),
                              onChanged: null,
                              // onChanged: (String? newValue) {
                              //   setState(() {
                              //     languageDropdownValue = newValue!;
                              //   });
                              // },
                              items: <String>[
                                'English',
                                'German',
                                'Turkish'
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
                              color: Theme.of(context).errorColor.withOpacity(0.5),
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
                              'Currency',
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
                              color: Theme.of(context).errorColor.withOpacity(0.5),
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
                    'Delete Account',
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
                    'Sign Out',
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
