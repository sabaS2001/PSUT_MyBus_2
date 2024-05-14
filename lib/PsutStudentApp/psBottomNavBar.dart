import 'package:flutter/material.dart';
import 'psHome.dart';
import 'psChat.dart';
import 'psBusSchedule.dart';
import 'psQRCode.dart';
import 'psSettings.dart';

class PSNavBar extends StatefulWidget {
  const PSNavBar({super.key});

  @override
  _PSNavBar createState() => _PSNavBar();
}

class _PSNavBar extends State<PSNavBar> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    //pages
    const PSHomePage(),
    const PSChat(),
    const PSBusSchedule(),
    PSQRCode(),
    const PSSettings()
  ];

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
        items:  const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon:  Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon:  Icon(Icons.chat_bubble_outlined),
            label: 'Chat',
          ),
           BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon:  Icon(Icons.menu_book_outlined),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon:  Icon(Icons.qr_code_scanner_sharp),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon:  Icon(Icons.settings_rounded),
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
