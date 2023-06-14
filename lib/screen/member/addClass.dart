import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/data/userLogin.dart';
import 'package:gofit_mobile_frontend/screen/member/elementUI.dart';
import 'package:gofit_mobile_frontend/screen/member/pindahProcess.dart';
import 'package:gofit_mobile_frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddBookClass extends StatefulWidget {
  const AddBookClass({super.key});

  @override
  State<AddBookClass> createState() => _AddBookClassState();
}

class _AddBookClassState extends State<AddBookClass> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahMember.cekPindah(context, _selectedIndex);
  }

  Future<List<dynamic>> getClass() async {
    var url = Uri.parse(kDomainName + 'data-jadwal-harian');
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

  void bookingKelas(String idKelas) async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(kDomainName + 'booking-kelas');
    var response = await http.post(url, body: {
      'id': currentUser!.id_user.toString(),
      'idKelas': idKelas,
    });
    var data = response.body;
    var decodedData = jsonDecode(data);
    print(decodedData['message']);
    if (response.statusCode == 200) {
      confirmBooking(context, decodedData['message'], color: Colors.green);
    } else {
      confirmBooking(context, decodedData['message'], color: Colors.red);
    }
  }

  void confirmBooking(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MemberElementUI.appBarMember(),
      body: FutureBuilder(
        future: getClass(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(
              child: Text('Tidak Ada List Kelas Hari ini'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                        'Nama Kelas       : ${snapshot.data?[index]['nama_kelas']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Tanggal Kelas        : ${snapshot.data?[index]['TANGGAL']}'),
                        Text(
                            'Nama Instruktur    : ${snapshot.data?[index]['nama_instruktur']}'),
                        Text(
                            'Sisa Member Kelas  : ${snapshot.data?[index]['SISA_MEMBER_KELAS']}'),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Booking kelas ini?'),
                                    actions: [
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              var idKelas = snapshot
                                                  .data?[index]
                                                      ['ID_JADWAL_KELAS']
                                                  .toString();
                                              bookingKelas(idKelas as String);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ya'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Tidak'),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Booking'),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: MemberElementUI.BtnNavBarMember(4, _onTapItem),
    );
  }
}
