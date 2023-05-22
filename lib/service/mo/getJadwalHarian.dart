import 'package:flutter/material.dart';
import '../../data/userLogin.dart';
import '../../utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetJadwalHarian {
  Future<List<dynamic>> getDataJadwalHarian() async {
    var url = Uri.parse(kDomainName + 'tampil-kelas-hari-ini');
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

  Future<void> updateMulai(
      String id, BuildContext context, Function cekMulaiSelesai) async {
    var url = Uri.parse(kDomainName + 'update-waktu-mulai-kelas/' + id);
    var response = await http.post(url);

    if (response.statusCode == 200) {
      try {
        var data = response.body;
        if (data.isNotEmpty) {
          var decodedData = jsonDecode(data);
          print(decodedData);
          if (decodedData is Map && decodedData.containsKey('message')) {
            cekMulaiSelesai(context, decodedData['message'].toString(),
                color: Colors.green);
          } else {
            print('Invalid JSON response');
          }
        } else {
          print('Empty JSON response');
        }
      } catch (e) {
        print('Error parsing JSON response: $e');
      }
    } else {
      var data = response.body;
      print('HTTP request error. Status code: ${response.statusCode}');
      try {
        if (data.isNotEmpty) {
          var decodedData = jsonDecode(data);
          if (decodedData is Map && decodedData.containsKey('message')) {
            cekMulaiSelesai(context, decodedData['message'].toString(),
                color: Colors.red);
          } else {
            print('Invalid JSON response');
          }
        } else {
          print('Empty JSON response');
        }
      } catch (e) {
        print('Error parsing JSON response: $e');
      }
    }
  }

  Future<void> updateSelesai(
      String id, BuildContext context, Function cekMulaiSelesai) async {
    var url = Uri.parse(kDomainName + 'update-waktu-selesai-kelas/' + id);
    var response = await http.post(url);

    if (response.statusCode == 200) {
      try {
        var data = response.body;
        if (data.isNotEmpty) {
          var decodedData = jsonDecode(data);
          print(decodedData);
          if (decodedData is Map && decodedData.containsKey('message')) {
            cekMulaiSelesai(context, decodedData['message'].toString(),
                color: Colors.green);
          } else {
            print('Invalid JSON response');
          }
        } else {
          print('Empty JSON response');
        }
      } catch (e) {
        print('Error parsing JSON response: $e');
      }
    } else {
      var data = response.body;
      print('HTTP request error. Status code: ${response.statusCode}');
      try {
        if (data.isNotEmpty) {
          var decodedData = jsonDecode(data);
          if (decodedData is Map && decodedData.containsKey('message')) {
            cekMulaiSelesai(context, decodedData['message'].toString(),
                color: Colors.red);
          } else {
            print('Invalid JSON response');
          }
        } else {
          print('Empty JSON response');
        }
      } catch (e) {
        print('Error parsing JSON response: $e');
      }
    }
  }
}
