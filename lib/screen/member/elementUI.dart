import 'package:flutter/material.dart';

class MemberElementUI {
  static AppBar appBarMember() {
    return AppBar(
      title: Center(
        child: const Text('Member'),
      ),
      backgroundColor: Colors.blue,
    );
  }

  static BottomNavigationBar BtnNavBarMember(
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
          icon: Icon(Icons.class_),
          label: 'Class',
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'add class',
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
