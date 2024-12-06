import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Calls.dart';
import 'Updates.dart';
import 'UserHomePage.dart';

class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({Key? key}) : super(key: key);

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const UserHomePage(),
    const Updates(),
    const Calls(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: const [
                Icon(Icons.chat_sharp, ),
                SizedBox(height: 8),
              ],
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: const [
                Icon(Icons.cached, ),
                SizedBox(height: 8),
              ],
            ),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: const [
                Icon(Icons.call, ),
                SizedBox(height: 8),
              ],
            ),
            label: 'Calls',
          ),
        ],
      ),
    );
  }
}