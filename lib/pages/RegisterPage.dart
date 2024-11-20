// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/authServices.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required String username,
    required String password,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              username = value;
            },
            decoration: const InputDecoration(
                hintText: 'Username',
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue))),
          ),
          TextFormField(
            onChanged: (value) {
              password = value;
            },
            decoration: const InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.blue))),
          ),
          ElevatedButton(
            onPressed: () {
              authServices.simpanAkun(username, password);

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text("register"),
          ),
        ],
      )),
    );
  }
}
