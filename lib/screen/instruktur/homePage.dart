import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/elementINS.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/pindahInstruktur.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pindahIns.pindahPageIns(context, _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InsMaterialUI.appBarIns(),
      body: Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: InsMaterialUI.BtnNavBarIns(0, _onTapItem),
    );
  }
}
