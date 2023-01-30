import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fts/login/homepage.dart';
import 'package:fts/login/otpscreen.dart';
import 'package:fts/login/phoneverification.dart';

Color PrimaryColor = const Color.fromARGB(255, 84, 22, 208);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => const phoneverification(),
      'verify': (context) => const otpscreen(),
      'home': (context) => const Home(),
    },
  ));
}
