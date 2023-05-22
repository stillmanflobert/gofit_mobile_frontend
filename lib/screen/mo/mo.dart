import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/mo/appBarMO.dart';
import 'package:gofit_mobile_frontend/screen/mo/pindahProcess.dart';
import 'package:gofit_mobile_frontend/service/mo/getJadwalHarian.dart';

class MoIndex extends StatefulWidget {
  const MoIndex({Key? key}) : super(key: key);

  @override
  State<MoIndex> createState() => _MoIndexState();
}

class _MoIndexState extends State<MoIndex> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Pindah.cekPindah(context, _selectedIndex);
  }

  Future<List<dynamic>> fetchDataJadwal() async {
    return await GetJadwalHarian().getDataJadwalHarian();
  }

  void cekMulaiSelesai(BuildContext context, String message, {Color? color}) {
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

  void updateWaktuMulai(item) async {
    var id = item['ID_JADWAL_KELAS'].toString();
    var update =
        await GetJadwalHarian().updateMulai(id, context, cekMulaiSelesai);
  }

  void updateWaktuSelesai(item) async {
    var id = item['ID_JADWAL_KELAS'].toString();
    var update =
        await GetJadwalHarian().updateSelesai(id, context, cekMulaiSelesai);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoAcc.appBarMO(),
      body: FutureBuilder<List<dynamic>>(
        future: fetchDataJadwal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final jadwal = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(jadwal['nama_kelas'].toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tanggal     : ${jadwal['TANGGAL'].toString()}'),
                        Text(
                            'Sesi            : ${jadwal['sesi_jadwal_default'].toString()}'),
                        Text(
                            'Hari            : ${jadwal['hari_jadwal_default'].toString()}'),
                        Text('Instruktur  : ${jadwal['nama_instruktur']}'),
                        Text(
                            'Waktu        : ${jadwal['WAKTU_MULAI_KELAS']} - ${jadwal['WAKTU_SELESAI_KELAS']}'),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                updateWaktuMulai(jadwal);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  'Mulai',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                updateWaktuSelesai(jadwal);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  'Selesai',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: Text('Data Kosong'),
          ); // Placeholder ketika tidak ada data
        },
      ),
      bottomNavigationBar: MoAcc.BtnNavBarMO(0, _onTapItem),
    );
  }
}
