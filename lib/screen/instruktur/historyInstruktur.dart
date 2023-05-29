import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/elementINS.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/pindahInstruktur.dart';
import '../../data/userLogin.dart';
import '../../utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryIns extends StatefulWidget {
  const HistoryIns({super.key});

  @override
  State<HistoryIns> createState() => _HistoryInsState();
}

class _HistoryInsState extends State<HistoryIns> {
  int _selectedIndex = 0;
  void _ontTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahIns.pindahPageIns(context, _selectedIndex);
  }

  Future<List<dynamic>> getHistoryPresensi() async {
    User? currentUser = UserManager().currentUser;
    print(currentUser!.id_user.toString());
    var url = Uri.parse(
        kDomainName + 'presensi-instruktur/' + currentUser!.id_user.toString());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InsMaterialUI.appBarIns(),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: getHistoryPresensi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Presensi Insturktur',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200, // Ubah sesuai dengan kebutuhan
                        child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(
                                    'Waktu Presensi       : ${snapshot.data?[index]['WAKTU_PRESENSI']}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Waktu Mulai Kelas       : ${snapshot.data?[index]['WAKTU_MULAI_KELAS']}'),
                                    Text(
                                        'Waktu Selesai Kelas    : ${snapshot.data?[index]['WAKTU_SELESAI_KELAS']}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                      child: Text('Insturktur belum pernah presensi'));
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: InsMaterialUI.BtnNavBarIns(2, _ontTapItem),
    );
  }
}
