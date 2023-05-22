import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/mo/mo.dart';
import 'package:gofit_mobile_frontend/screen/mo/test.dart';

class MoAcc {
  static AppBar appBarMO() {
    return AppBar(
      title: const Center(
        child: Text('Manager Operasional'),
      ),
    );
  }

  static BottomNavigationBar BtnNavBarMO(
    int selectedIndex,
    void Function(int) onTap,
  ) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        )
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      selectedIconTheme: IconThemeData(
          color: Colors.blue), // Ubah warna ikon yang dipilih di sini
      onTap: onTap,
    );
  }
}
