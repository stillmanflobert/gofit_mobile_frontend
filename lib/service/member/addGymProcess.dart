import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gofit_mobile_frontend/data/userLogin.dart';

class AddGymProcess {
  String hari;
  int sesi;

  AddGymProcess({required this.hari, required this.sesi});

  Future<void> addGym(
      BuildContext context, Function successAddGym, Function failAddGym) async {
    User? currentUser = UserManager().currentUser;
    var id_user = currentUser?.id_user;
    print(id_user);
    print(this.hari);
    print(this.sesi);
    var url = Uri.parse(kDomainName + 'booking-sesi-gym');
    var response = await http.post(
      url,
      body: {
        'id_member': id_user.toString(),
        'hari_gym': this.hari,
        'sesi_gym': this.sesi.toString(),
      },
    );

    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      print(decodedData);
      successAddGym(context, decodedData['message'].toString());
    } else {
      var data = response.body;
      var decodedData = jsonDecode(data);
      print(response.body);
      failAddGym(context, decodedData['message'].toString());
    }
  }
}
