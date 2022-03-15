import 'package:flutter/material.dart';

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
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Divider(color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      DropdownButton<String>(
                        value: languageDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        underline: Container(
                          height: 1,
                          color: Colors.white,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            languageDropdownValue = newValue!;
                          });
                        },
                        items: <String>['English', 'German', 'Turkish']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Appereance',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      DropdownButton<String>(
                        value: appereanceDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        underline: Container(
                          height: 1,
                          color: Colors.white,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            appereanceDropdownValue = newValue!;
                          });
                        },
                        items: <String>['Dark Mode', 'Light Mode']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Divider(color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Currency',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      DropdownButton<String>(
                        value: currencyDropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        underline: Container(
                          height: 1,
                          color: Colors.white,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            currencyDropdownValue = newValue!;
                          });
                        },
                        items: <String>['USD', 'EUR', 'GBP']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
