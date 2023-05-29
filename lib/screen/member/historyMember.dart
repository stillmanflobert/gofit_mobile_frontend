import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/member/elementUI.dart';
import 'package:gofit_mobile_frontend/screen/member/pindahProcess.dart';
import 'package:gofit_mobile_frontend/data/userLogin.dart';
import 'package:gofit_mobile_frontend/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryMember extends StatefulWidget {
  const HistoryMember({Key? key});

  @override
  State<HistoryMember> createState() => _HistoryMemberState();
}

class _HistoryMemberState extends State<HistoryMember> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> getHistoryAktivasi() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(
        kDomainName + 'transaksi-aktivasi/' + currentUser!.id_user.toString());
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

  Future<List<dynamic>> getHistoryDepositUang() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(kDomainName +
        'transaksi-deposit-uang/' +
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

  Future<List<dynamic>> getHistoryDepositKelas() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(kDomainName +
        'transaksi-deposit-kelas/' +
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

  Future<List<dynamic>> getHistoryPresensiGym() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(
        kDomainName + 'presensi-member-gym/' + currentUser!.id_user.toString());
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

  Future<List<dynamic>> getHistoryPresensiKelas() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(kDomainName +
        'presensi-member-kelas/' +
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

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahMember.cekPindah(context, _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MemberElementUI.appBarMember(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<dynamic>>(
              future: getHistoryAktivasi(),
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
                    child: Text('Belum Ada Aktivasi'),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Transaksi Aktivasi',
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
                                    'ID Transaksi       : ${snapshot.data?[index]['ID_TRANSAKSI_AKTIVASI']}'),
                                subtitle: Text(
                                    'Tanggal Transaksi : ${snapshot.data?[index]['TGL_TRANSAKSI_AKTIVASI']}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder<List<dynamic>>(
              future: getHistoryDepositUang(),
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
                    child: Text('Belum pernah Deposit Uang'),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Transaksi Deposit Uang',
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
                                    'ID Transaksi       : ${snapshot.data?[index]['ID_TRANSAKSI_DEPOSIT_UANG']}'),
                                subtitle: Text(
                                    'Tanggal Transaksi : ${snapshot.data?[index]['TGL_TRANSAKSI_DEPOSIT_UANG']}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder<List<dynamic>>(
              future: getHistoryDepositKelas(),
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
                    child: Text('Belum pernah Deposit Kelas'),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Transaksi Deposit Kelas',
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
                                    'ID Transaksi       : ${snapshot.data?[index]['ID_TRANSAKSI_DEPOSIT_KELAS']}'),
                                subtitle: Text(
                                    'Tanggal Transaksi : ${snapshot.data?[index]['TGL_TRANSAKSI_DEPOSIT_KELAS']}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder(
              future: getHistoryPresensiGym(),
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
                    child: Text('Belum pernah Presensi Gym'),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Presensi Gym',
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
                                    'ID Presensi       : ${snapshot.data?[index]['ID_PRESENSI_GYM']}'),
                                subtitle: Text(
                                    'Tanggal Presensi : ${snapshot.data?[index]['WAKTU_PRESENSI_MEMBER_GYM']}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            FutureBuilder(
              future: getHistoryPresensiKelas(),
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
                    child: Text('Belum pernah Presensi Kelas'),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Presensi Kelas',
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
                                    'ID Presensi       : ${snapshot.data?[index]['ID_PRESENSI_KELAS']}'),
                                subtitle: Text(
                                    'Tanggal Presensi : ${snapshot.data?[index]['WAKTU_PRESENSI_MEMBER_KELAS']}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: MemberElementUI.BtnNavBarMember(
        2,
        _onTapItem,
      ),
    );
  }
}
