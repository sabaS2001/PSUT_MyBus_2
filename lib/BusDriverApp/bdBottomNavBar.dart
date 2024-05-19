import 'package:flutter/material.dart';
import 'package:psut_my_bus/BusDriverApp/bdStudentList.dart';
import 'bdHomePage.dart';
import 'bdSettings.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBar createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [const BDHomePage(), const BDStudentList(), BDSettings()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
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
            icon: Icon(Icons.qr_code_scanner_sharp),
            label: 'QR Code Student List',
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
