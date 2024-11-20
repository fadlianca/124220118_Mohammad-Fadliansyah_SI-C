// ignore_for_file: prefer_const_constructors, file_names, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';

import '../services/authServices.dart';
import 'HomePage.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  bool isLoginSucces = true;
  bool isVisible = true;
  bool isClicked = true;

  //function redirect
  _navigatetoHome() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  username: username,
                  password: password,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          usernameField(),
          passwordField(),
          LoginButton(context),
          RegisterButton(context),
        ],
      ),
    ));
  }

  Widget usernameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
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
    );
  }

  Widget passwordField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        obscureText: isVisible,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
            suffix: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: const Icon(Icons.visibility),
            ),
            hintText: 'Password',
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }

  Widget LoginButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          Future<bool> isLoginSucces = authServices.login(username, password);
          String text = '';
          if (await isLoginSucces) {
            _navigatetoHome();

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Login Berhasil')));

            setState(() {
              isClicked = !isClicked;
              print(isClicked);
            });
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Login Gagal Cuy')));
          }

          SnackBar snackBar = SnackBar(
            content: Text(text),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Login'),
      ),
    );
  }

  Widget RegisterButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      RegisterPage(username: username, password: password)));
        },
        child: const Text('Register'),
      ),
    );
  }
}
