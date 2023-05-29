import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/member/elementUI.dart';
import 'package:gofit_mobile_frontend/screen/member/pindahProcess.dart';
import '../../utilities/constants.dart';
import '../../data/userLogin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class ProfilMember extends StatefulWidget {
  const ProfilMember({super.key});

  @override
  State<ProfilMember> createState() => _ProfilMemberState();
}

class _ProfilMemberState extends State<ProfilMember> {
  int _selectedIndex = 0;
  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    User? currentUser = UserManager().currentUser;
    var url =
        Uri.parse(kDomainName + 'member/' + currentUser!.id_user.toString());
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
                          labelText: 'ID member',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller:
                            TextEditingController(text: data['ID_MEMBER']),
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
                        controller:
                            TextEditingController(text: data['NAMA_MEMBER']),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(text: data['EMAIL']),
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
                        controller:
                            TextEditingController(text: data['TELEPON_MEMBER']),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Deposit Uang',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                            text: data['JUMLAH_DEPOSIT_UANG'].toString()),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Tanggal Ekspired',
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        readOnly: true,
                        controller: TextEditingController(
                            text: data['WAKTU_AKTIVASI_EKSPIRED'].toString()),
                      ),
                    ),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
      bottomNavigationBar: MemberElementUI.BtnNavBarMember(1, _onTapItem),
    );
  }
}
