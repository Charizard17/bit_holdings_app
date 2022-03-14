import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  static const List<Widget> _screenList = [
    Center(
      child: Text('Home Screen'),
    ),
    Center(
      child: Text('Portfolio Screen'),
    ),
    Center(
      child: Text('Settings Screen'),
    ),
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
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
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
