import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fswitch/fswitch.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupBackHomePage.dart';
import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigrationBar(),
      ),
    );
  }

  void navigateToService() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE);
  }

  void navigateToHomePage() {
    Navigator.pushNamed(context, HOMEPAGE_ROUTE);
  }

  void trackingRequestService() {
    Navigator.pushNamed(context, TRACKING_REQUEST_ROUTE);
  }
}
