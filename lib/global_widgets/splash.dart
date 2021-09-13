import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: Image.asset(
        'assets/launcher/ic_launcher.png',
        width: 250,
      )),
    );
  }
}

// class Init {
//   Init._();
//   static final instance = Init._();

//   Future initialize() async {
//     await Future.delayed(Duration(seconds: 3));
//   }

// }
