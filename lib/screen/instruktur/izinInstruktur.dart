import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/elementINS.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/pindahInstruktur.dart';
import '../../data/userLogin.dart';
import '../../utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IzinInstruktur extends StatefulWidget {
  const IzinInstruktur({super.key});

  @override
  State<IzinInstruktur> createState() => _IzinInstrukturState();
}

class _IzinInstrukturState extends State<IzinInstruktur> {
  int _selectedIndex = 0;
  void _ontTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahIns.pindahPageIns(context, _selectedIndex);
  }

  Future<List<dynamic>> getIzin() async {
    User? currentUser = UserManager().currentUser;
    print(currentUser!.id_user.toString());
    var url = Uri.parse(
        kDomainName + 'izin-instruktur/' + currentUser!.id_user.toString());
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
      body: FutureBuilder(
          future: getIzin(),
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
                child: Text('Belum Pernah mengajukan izin'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            'Tanggal Izin : ${snapshot.data?[index]['WAKTU_IZIN']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Status : ${snapshot.data?[index]['STATUS_IZIN']}'),
                            Text(
                                'Keterangan : ${snapshot.data?[index]['KETERANGAN']}'),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }),
      bottomNavigationBar: InsMaterialUI.BtnNavBarIns(3, _ontTapItem),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
