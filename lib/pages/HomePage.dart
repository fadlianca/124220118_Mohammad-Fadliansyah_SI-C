// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lat_responsi/pages/SecondPage.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String password;

  const HomePage({super.key, required this.username, required this.password});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $_username!"),
        titleTextStyle: TextStyle(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Restaurants(
              pictureId: "",
              name: "",
              city: "",
            ),
            SizedBox(height: 20),
            Restaurants(
              pictureId: "https://restaurant-api.dicoding.dev/images/small/14",
              name: "Melting Pot",
              city: "",
            ),
            SizedBox(height: 20),
            Restaurants(
              pictureId: "",
              name: "",
              city: "",
            ),
          ],
        ),
      ),
    );
  }
}

class Restaurants extends StatelessWidget {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  const Restaurants({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  get endpoint => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(endpoint: endpoint),
          ),
        );
      },
      child: Container(
        height: 120, // Tambahkan tinggi tetap untuk memperbesar ukuran
        padding: EdgeInsets.all(20), // Tingkatkan padding untuk kesan luas
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.deepPurple, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }
}
