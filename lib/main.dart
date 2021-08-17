import 'package:flutter/material.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/currentLocation.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/homePage.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/moreInfoGarageCard.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/global_widgets/navigrationBar.dart';
import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RodSia',
      theme: ThemeData(primaryColor: hexToColor("#FECE2F")),
      home: Scaffold(body: CurrentLocation()),

      // initialRoute: '/',
      // routes: {
      //   BottomNavigrationBar.routeName: (context) => BottomNavigrationBar()
      // },
    );
  }
}
