import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_flutter/screens/loginscreen.dart';
import 'package:ui_flutter/screens/user_info.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkUser() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const UserInfoPage(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const LogInScreen(),
      ));
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), checkUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
          child: Image.asset(
        'assets/flutter_icon_white.png',
      )),
    );
  }
}
