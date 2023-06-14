import 'package:flutter/material.dart';

class InsMaterialUI {
  static AppBar appBarIns() {
    return AppBar(
      title: Center(
        child: const Text('Instruktur'),
      ),
      backgroundColor: Colors.blue,
    );
  }

  static BottomNavigationBar BtnNavBarIns(
    int selectedIndex,
    void Function(int) onTap,
  ) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Izin',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
          backgroundColor: Colors.blue,
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      onTap: onTap,
    );
  }
}
