import 'package:flutter/material.dart';
import 'bdHomePage.dart';
import 'bdSettings.dart';
import 'bdChat.dart';
import 'bdQRScanner.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [const BDHomePage(), const BDChat(), const BDQRScan(), const BDSettings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outlined),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_sharp),
            label: 'QR Code Student',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromRGBO(11, 39, 143, 1.0),
        unselectedItemColor: const Color.fromRGBO(11, 39, 143, 1.0),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Wellfleet',
          fontSize: 11.0,
        ),
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Wellfleet',
          fontSize: 11.0,
        ),
      ),
    );
  }
}
