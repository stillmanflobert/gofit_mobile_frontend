import 'package:flutter/material.dart';
import '../../data/userLogin.dart';
import '../../utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetBookingGym {
  Future<List<dynamic>> getDataGym() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(
        kDomainName + 'booking-sesi-gym/' + currentUser!.id_user.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      print(decodedData['data']);
      return decodedData['data'] as List<dynamic>;
    } else {
      print(response.body);
      return [];
    }
  }

  Future<void> batalGym(String idGym, String idBookingGym, BuildContext context,
      Function confirmBatalGym) async {
    var url = Uri.parse(kDomainName + 'batal-booking-gym');
    var response = await http.post(
      url,
      body: {
        'id_gym': idGym,
        'id_booking_gym': idBookingGym,
      },
    );

    if (response.statusCode == 200) {
      try {
        var data = response.body;
        var decodedData = jsonDecode(data);
        print(decodedData);
        confirmBatalGym(context, decodedData['message'].toString(),
            color: Colors.green);
      } catch (e) {
        print('Error parsing JSON response: $e');
        // Lakukan penanganan kesalahan yang sesuai, misalnya menampilkan pesan kesalahan
      }
    } else {
      var data = response.body;
      var decodedData = jsonDecode(data);
      print('HTTP request error. Status code: ${response.statusCode}');
      confirmBatalGym(context, decodedData['message'].toString(),
          color: Colors.red);
      // Lakukan penanganan kesalahan yang sesuai, misalnya menampilkan pesan kesalahan
    }
  }
}
