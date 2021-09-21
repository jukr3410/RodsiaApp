import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fswitch/fswitch.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupBackHomePage.dart';
import 'package:rodsiaapp/global_widgets/bottomNavigrationBarPage.dart';

class CustomAppBar extends StatefulWidget {
  final User user;
  const CustomAppBar({Key? key, required this.user}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigrationBar(user: widget.user),
      ),
    );
  }

  Widget testWidgets() {
    return BottomNavigrationBar(user: widget.user);
  }

  void navigateToService() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE);
  }

  void navigateToHomePage() {
    Navigator.pushNamed(context, HOMEPAGE_ROUTE, arguments: widget.user);
  }

  void trackingRequestService() {
    Navigator.pushNamed(context, TRACKING_REQUEST_ROUTE);
  }
}
