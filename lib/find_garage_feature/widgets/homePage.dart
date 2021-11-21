import 'package:flutter/material.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/viewBars.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/constants.dart';

class HomePage extends StatefulWidget {
  final FilterGarageModel filter;
  const HomePage({Key? key, required this.filter}) : super(key: key);
  static const routeHome = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ViewBars(
      filter: widget.filter,
    )));
  }
}
