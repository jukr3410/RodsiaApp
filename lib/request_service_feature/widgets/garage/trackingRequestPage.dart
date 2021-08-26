import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/request_service_feature/widgets/garage/barTrackingPage.dart';
import 'package:rodsiaapp/request_service_feature/widgets/garage/buttonTrackingStatus.dart';
import 'package:rodsiaapp/request_service_feature/widgets/garage/locationUser.dart';
import 'package:rodsiaapp/request_service_feature/widgets/garage/nameGarageAndUser.dart';

class TrackingRequestPage extends StatefulWidget {
  TrackingRequestPage({Key? key}) : super(key: key);

  @override
  _TrackingRequestPageState createState() => _TrackingRequestPageState();
}

class _TrackingRequestPageState extends State<TrackingRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          NameGarageAndUser(),
          LocationUser(),
          BarTrackingpage(),
          SizedBox(
            height: 5,
          ),
          ButtonTrackingStatus()
        ],
      ),
    );
  }
}
