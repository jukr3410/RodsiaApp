import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/request_service_feature/widgets/trackingRequestCard.dart';

class TrackingRequestPage extends StatefulWidget {
  String requestServiceId;
  TrackingRequestPage({Key? key, required this.requestServiceId})
      : super(key: key);

  @override
  _TrackingRequestPageState createState() => _TrackingRequestPageState();
}

class _TrackingRequestPageState extends State<TrackingRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: primaryColor,
        title: Container(
          alignment: Alignment.centerRight,
          child: GFButton(
            type: GFButtonType.transparent,
            textStyle: TextStyle(fontSize: 14, color: textColorBlack),
            child: Text(tSupportThai),
            onPressed: () {},
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 45,
        color: primaryColor,
        child: Text(tInSeriveThai),
        alignment: Alignment.center,
      ),
      backgroundColor: bgColor,
      body: Column(
        children: [TrackingRequestCard()],
      ),
    );
  }
}
