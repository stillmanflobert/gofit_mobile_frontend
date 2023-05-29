import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/elementINS.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/pindahInstruktur.dart';
import '../../data/userLogin.dart';
import '../../utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahIns.pindahPageIns(context, _selectedIndex);
  }

  Future<void> getData() async {
    User? currentUser = UserManager().currentUser;
    var url = Uri.parse(
        kDomainName + 'instruktur/' + currentUser!.id_user.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      print(decodedData['data']);
      setState(() {
        this.data = decodedData['data'];
      });
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InsMaterialUI.appBarIns(),
      body: Center(
        child: data.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/premium-vector/fitness-gym-logo-premium-vector_144543-140.jpg?w=740'), // Ganti dengan URL gambar tema gym yang sesuai
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'ID instruktur',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                            text: data['USERNAME_INSTRUKTUR']),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                            text: data['NAMA_INSTRUKTUR']),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Alamat Instruktur',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                            text: data['ALAMAT_INSTRUKTUR']),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                            text: data['TELEPON_INSTRUKTUR']),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Tanggal Lahir',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                          text: data['TANGGAL_LAHIR'],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Total Keterlambatan',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                          text:
                              '${data['TOTAL_KETERLAMBATAN'].toString()} detik',
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
      bottomNavigationBar: InsMaterialUI.BtnNavBarIns(1, _onTapItem),
    );
  }
}
