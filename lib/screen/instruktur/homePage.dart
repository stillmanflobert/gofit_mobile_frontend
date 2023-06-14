import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/elementINS.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/pindahInstruktur.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gofit_mobile_frontend/utilities/constants.dart';
import 'package:gofit_mobile_frontend/data/userLogin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String? selectedInstruktur;
  String alasan = '';

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahIns.pindahPageIns(context, _selectedIndex);
  }

  Future<List<dynamic>> getJadwalInstruktur() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(kDomainName +
        'data-kelas-instruktur/' +
        currentUser!.id_user.toString());
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

  Future<List<dynamic>> getInstruktur() async {
    var url = Uri.parse(kDomainName + 'instruktur');
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

  void tambahIzin(String idKelas) async {
    if (selectedInstruktur == null || alasan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBar('Isi semua inputan', Colors.red),
      );
      print(selectedInstruktur);
      print(alasan);
      return;
    }
    await izinInstruktur(idKelas);
  }

  Future<void> izinInstruktur(String id) async {
    var url = Uri.parse(kDomainName + 'tambah-izin');
    User? currentUser = UserManager().currentUser;
    var response = await http.post(url, body: {
      'username_instruktur': currentUser!.id_user.toString(),
      'id_instruktur_pengganti': selectedInstruktur!,
      'keterangan': alasan,
      'id_jadwal_kelas': id
    });
    if (response.statusCode == 200) {
      showSnackBar('Berhasil Mengajukan Izin', Colors.green);
      print(response.body);
    } else {
      var data = response.body;
      var decodedData = jsonDecode(data);
      showSnackBar(decodedData['message'] as String, Colors.red);
      print(response.body);
    }
  }

  SnackBar showSnackBar(String message, Color color) {
    return SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InsMaterialUI.appBarIns(),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: getJadwalInstruktur(),
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
                child: Text('Tidak ada jadwal mengajar minggu ini'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var jadwal = snapshot.data?[index];
                  var tanggal = jadwal?['TANGGAL'];
                  var sisaSlot = jadwal?['SISA_MEMBER_KELAS'];
                  var status = jadwal?['STATUS'];

                  return Card(
                    child: ListTile(
                      title: Text('Tanggal: $tanggal'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sisa slot: $sisaSlot'),
                          if (status == 1) Text('Status: aktif'),
                          if (status == 0) Text('Status: batal'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        child: Text('Ajukan izin'),
                        onPressed: () async {
                          var instrukturList = await getInstruktur();
                          selectedInstruktur =
                              instrukturList![0]['ID_INSTRUKTUR'].toString();

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Pilih instruktur pengganti'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownButton<String>(
                                      value: selectedInstruktur,
                                      items: instrukturList
                                          ?.map<DropdownMenuItem<String>>(
                                              (instruktur) {
                                        var id = instruktur['ID_INSTRUKTUR'];
                                        var nama =
                                            instruktur['NAMA_INSTRUKTUR'];
                                        return DropdownMenuItem<String>(
                                          value: id.toString(),
                                          child: Text(nama),
                                        );
                                      }).toList(),
                                      onChanged: (selectedValue) {
                                        setState(() {
                                          selectedInstruktur = selectedValue;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    Text('Alasan'),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Alasan izin',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          alasan = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      var id =
                                          jadwal?['ID_JADWAL_KELAS'].toString();
                                      tambahIzin(id!);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: InsMaterialUI.BtnNavBarIns(0, _onTapItem),
    );
  }
}
