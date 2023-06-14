import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/historyInstruktur.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/izinInstruktur.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/profilePage.dart';
import 'package:gofit_mobile_frontend/screen/loginScreen.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/homePage.dart';
import '../../data/userLogin.dart';

class pindahIns {
  static void pindahPageIns(contex, int selectedIndex) {
    if (selectedIndex == 0) {
      Navigator.pushReplacement(
        contex,
        MaterialPageRoute(builder: (contex) => HomePage()),
      );
    } else if (selectedIndex == 1) {
      Navigator.pushReplacement(
        contex,
        MaterialPageRoute(builder: (contex) => ProfilePage()),
      );
    } else if (selectedIndex == 2) {
      Navigator.pushReplacement(
        contex,
        MaterialPageRoute(builder: (contex) => HistoryIns()),
      );
    } else if (selectedIndex == 3) {
      Navigator.pushReplacement(
        contex,
        MaterialPageRoute(builder: (contex) => IzinInstruktur()),
      );
    } else if (selectedIndex == 4) {
      UserManager().logout();
      Navigator.pushReplacement(
        contex,
        MaterialPageRoute(builder: (contex) => LoginScreen()),
      );
    }
  }
}
