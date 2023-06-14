import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/data/userLogin.dart';
import 'package:gofit_mobile_frontend/screen/member/elementUI.dart';
import 'package:gofit_mobile_frontend/screen/member/pindahProcess.dart';
import 'package:gofit_mobile_frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddKelas extends StatefulWidget {
  const AddKelas({Key? key}) : super(key: key);

  @override
  State<AddKelas> createState() => _AddKelasState();
}

class _AddKelasState extends State<AddKelas> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahMember.cekPindah(context, _selectedIndex);
  }

  Future<List<dynamic>> getDataKelas() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(
        kDomainName + 'data-jadwal-member/' + currentUser!.id_user.toString());
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

  void batalKelas(String idBooking) async {
    var url =
        Uri.parse(kDomainName + 'batal-booking-kelas/' + idBooking.toString());
    var response = await http.post(url);
    var data = response.body;
    var decodedData = jsonDecode(data);
    print(decodedData['message']);
    if (decodedData['message'] == 'booking kelas berhasil dibatalkan') {
      confirmBataKelas(context, decodedData['message'], color: Colors.green);
    } else {
      confirmBataKelas(context, decodedData['message'], color: Colors.red);
    }
  }

  void confirmBataKelas(BuildContext context, String message, {Color? color}) {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MemberElementUI.appBarMember(),
      body: FutureBuilder<List<dynamic>>(
        future: getDataKelas(),
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
              child: Text('Belum Ada Booking Kelas'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                        'ID Booking         : ${snapshot.data?[index]['ID_BOOKING_KELAS']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Tanggal Booking   : ${snapshot.data?[index]['TGL_BOOKING_KELAS']}'),
                        Text(
                            'Status Booking      : ${snapshot.data?[index]['STATUS_BOOKING_KELAS']}'),
                        Text(
                            'Nama Kelas           : ${snapshot.data?[index]['nama_kelas']}'),
                        Text(
                            'Nama Instruktur   : ${snapshot.data?[index]['nama_instruktur']}'),
                        Text(
                            'Tanggal Kelas       : ${snapshot.data?[index]['tanggal']}'),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Batalkan kelas ini?'),
                                  actions: [
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            var id = snapshot.data?[index]
                                                    ['ID_BOOKING_KELAS']
                                                .toString();
                                            batalKelas(id as String);
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
                          child: Text('Batal'),
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
      bottomNavigationBar: MemberElementUI.BtnNavBarMember(3, _onTapItem),
    );
  }
}
