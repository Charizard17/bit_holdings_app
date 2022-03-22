import 'package:flutter/material.dart';

import 'home_screen.dart';
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
  static const List<Widget> _screenList = [
    // HomeScreen(),
    CoinsListScreen(),
    PortfolioScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int value) {
      setState(() {
        _selectedIndex = value;
      });
    }

    return Scaffold(
      body: _screenList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.black,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home_outlined),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Coins',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outlined),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
