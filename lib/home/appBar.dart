import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fswitch/fswitch.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupBackHomePage.dart';
import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';

class CustomAppBar extends StatefulWidget {
  final FilterGarageModel filter;
  const CustomAppBar({Key? key, required this.filter}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigrationBar(
          filter: widget.filter,
        ),
      ),
    );
  }
}
