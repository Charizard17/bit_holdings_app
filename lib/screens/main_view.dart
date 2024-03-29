import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'portfolio_screen.dart';
import 'settings_screen.dart';
import 'coins_list_screen.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  static List<Widget> _screenList = [
    CoinsListScreen(),
    PortfolioScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final appLocalizationsContext = AppLocalizations.of(context)!;

    void _onItemTapped(int value) {
      setState(() {
        _selectedIndex = value;
      });
    }

    return Scaffold(
      body: _screenList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 18,
        unselectedFontSize: 16,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).focusColor,
        unselectedItemColor: Theme.of(context).hintColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: appLocalizationsContext.coins,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outlined),
            label: appLocalizationsContext.portfolio,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: appLocalizationsContext.settings,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
