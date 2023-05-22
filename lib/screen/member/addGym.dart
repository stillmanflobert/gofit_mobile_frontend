import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/member/elementUI.dart';
import 'package:gofit_mobile_frontend/screen/member/pindahProcess.dart';
import 'package:gofit_mobile_frontend/service/member/addGymProcess.dart';
import 'package:gofit_mobile_frontend/service/member/getBookingGym.dart';

class AddGym extends StatefulWidget {
  const AddGym({Key? key}) : super(key: key);

  @override
  _AddGymState createState() => _AddGymState();
}

class _AddGymState extends State<AddGym> {
  int _selectedIndex = 0;
  List<String> days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
  List<int> sessions = [1, 2, 3, 4, 5, 6, 7];
  String selectedDay = 'Senin';
  int selectedSession = 1;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahMember.cekPindah(context, _selectedIndex);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> fetchDataGym() async {
    return await GetBookingGym().getDataGym();
  }

  void successAddGym(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
    setState(() {});
  }

  void failAddGym(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void confirmBatalGym(BuildContext context, String message, {Color? color}) {
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

  void addGymData() async {
    var add = await AddGymProcess(
      hari: selectedDay,
      sesi: selectedSession,
    ).addGym(context, successAddGym, failAddGym);
  }

  void batal(item) async {
    var idGym = item['ID_GYM'].toString();
    var idBookingGym = item['ID_BOOKING_GYM'].toString();
    var batal = await GetBookingGym()
        .batalGym(idGym, idBookingGym, context, confirmBatalGym);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MemberElementUI.appBarMember(),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: fetchDataGym(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<dynamic> dataGym = snapshot.data!;
              return ListView.builder(
                itemCount: dataGym.length,
                itemBuilder: (context, index) {
                  var gym = dataGym[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text(gym['nama_member']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Status Booking: ${gym['STATUS_BOOKING_GYM']}'),
                          Text('Hari Gym: ${gym['HARI_GYM']}'),
                          Text('Sesi Gym: ${gym['SESI_GYM']}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          batal(gym);
                        },
                        child: Text('Batal'),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('Data kosong');
            }
          },
        ),
      ),
      bottomNavigationBar: MemberElementUI.BtnNavBarMember(0, _onTapItem),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pilih Hari dan Sesi'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedDay,
                      onChanged: (String? value) {
                        setState(() {
                          selectedDay = value!;
                        });
                      },
                      items: days.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      value: selectedSession,
                      onChanged: (int? value) {
                        setState(() {
                          selectedSession = value!;
                        });
                      },
                      items: sessions.map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      addGymData();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
