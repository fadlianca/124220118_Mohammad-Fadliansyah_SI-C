// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'pages/login_page.dart';
import 'services/favorite_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final favoriteService = FavoriteService();
  await favoriteService.initHive();

=======
import 'pages/LoginPage.dart';

void main() {
>>>>>>> e815dd6da799761ba3c145966cd3ca86388dac05
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
