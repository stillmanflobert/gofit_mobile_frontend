import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/loginScreen.dart';
import 'package:gofit_mobile_frontend/screen/mo/mo.dart';
import 'package:gofit_mobile_frontend/screen/mo/test.dart';
import 'package:gofit_mobile_frontend/data/userLogin.dart';

class Pindah {
  static void cekPindah(BuildContext context, int selectedIndex) {
    if (selectedIndex == 0) {
      User? currentUser = UserManager().currentUser;
      print(currentUser?.password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MoIndex()),
      );
    } else if (selectedIndex == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Test()),
      );
    } else if (selectedIndex == 2) {
      UserManager().logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
