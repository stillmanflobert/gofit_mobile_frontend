import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/loginScreen.dart';
import 'package:gofit_mobile_frontend/screen/member/addGym.dart';
import 'package:gofit_mobile_frontend/data/userLogin.dart';
import 'package:gofit_mobile_frontend/screen/member/historyMember.dart';
import 'package:gofit_mobile_frontend/screen/member/profilMember.dart';

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
      User? currentUser = UserManager().currentUser;
      print(currentUser?.id_user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilMember()),
      );
    } else if (selectedIndex == 2) {
      User? currentUser = UserManager().currentUser;
      print(currentUser?.id_user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HistoryMember()),
      );
    } else if (selectedIndex == 3) {
      UserManager().logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
