import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fswitch/fswitch.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/alertPopupBackHomePage.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AlertPopupBackHomePage(),
    );
  }

  Widget testWidgets() {
    return Text("Test");
  }

  void navigateToService() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE);
  }

  void trackingRequestService() {
    Navigator.pushNamed(context, TRACKING_REQUEST_ROUTE);
  }
}
