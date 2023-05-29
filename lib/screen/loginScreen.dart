import 'package:flutter/material.dart';
import 'package:gofit_mobile_frontend/screen/instruktur/homePage.dart';
import 'package:gofit_mobile_frontend/screen/member/addGym.dart';
import 'package:gofit_mobile_frontend/utilities/constants.dart';
import 'package:gofit_mobile_frontend/service/loginProcess.dart';
import 'package:gofit_mobile_frontend/screen/mo/mo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String id = '';
  String password = '';

  SnackBar showSnackBar() {
    return SnackBar(
      content: const Text(
        'Please fill in all the fields',
        textAlign: TextAlign.center,
      ),
    );
  }

  void checkEmpty() {
    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        showSnackBar(),
      );
    }
  }

  void showErrorLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Wrong ID or Password',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void showSuccessLogin(String role) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Login Successful',
          textAlign: TextAlign.center,
        ),
      ),
    );

    if (role == 'manager operasional') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MoIndex()),
      );
    } else if (role == 'member') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddGym()),
      );
    } else if (role == 'instruktur') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      print('belum diketahui');
    }
  }

  void login() async {
    var loginData = await LoginProcess(id: this.id, password: this.password)
        .login(showErrorLogin, showSuccessLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(kUrlImageLink),
                radius: 70,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Anton',
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ID',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    id = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (this.id.isEmpty || this.password.isEmpty) {
                    checkEmpty();
                  } else {
                    login();
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
