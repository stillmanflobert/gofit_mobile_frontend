import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/loginScreen.dart';
import 'package:gofit_mobile_frontend/screen/member/addGym.dart';
import 'package:gofit_mobile_frontend/data/userLogin.dart';

class pindahMember {
  static void cekPindah(BuildContext context, int selectedIndex) {
    if (selectedIndex == 0) {
      User? currentUser = UserManager().currentUser;
      print(currentUser?.password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddGym()),
      );
    } else if (selectedIndex == 1) {
      UserManager().logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
