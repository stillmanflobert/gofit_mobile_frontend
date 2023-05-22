import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/mo/mo.dart';
import 'package:gofit_mobile_frontend/screen/mo/appBarMO.dart';
import 'package:gofit_mobile_frontend/screen/mo/pindahProcess.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Pindah.cekPindah(context, _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MoAcc.appBarMO(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: '),
            ElevatedButton(
              onPressed: () {},
              child: null,
            ),
          ],
        ),
      ),
      bottomNavigationBar: MoAcc.BtnNavBarMO(
        1,
        _onTapItem,
      ),
    );
  }
}
