import 'package:gofit_mobile_frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/loginScreen.dart';
import 'package:gofit_mobile_frontend/data/userLogin.dart';

class LoginProcess {
  LoginProcess({required this.id, required this.password});

  final String id;
  final String password;

  Future<void> login(Function showErrorLogin, Function showSuccesLogin) async {
    var url = Uri.parse(kDomainName + 'login');
    var response = await http.post(
      url,
      body: {
        'id_user': this.id,
        'password': this.password,
      },
    );

    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      print(decodedData);
      UserManager().login(
        User(
          id_user: decodedData['data']['id_user'],
          password: decodedData['data']['password'],
          role: decodedData['data']['role'],
        ),
      );
      showSuccesLogin(decodedData['data']['role']);
    } else {
      print(response.body);
      showErrorLogin();
    }
  }
}
