import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class AlertRequestService extends StatefulWidget {
  AlertRequestService({Key? key}) : super(key: key);

  @override
  _AlertRequestServiceState createState() => _AlertRequestServiceState();
}

class _AlertRequestServiceState extends State<AlertRequestService> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: AlertDialog(
        content: Container(
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          width: 317,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(image: AssetImage('image/icon-battery-service.png')),
              SizedBox(height: 20),
              Text(tAlertRequestService),
              SizedBox(height: 20),
              Text('แบตเตอรี่หมด'),
              Text('ระยะทาง 2.5 กิโลเมตร'),
              SizedBox(height: 30),
              Container(
                height: 40,
                width: double.infinity,
                child: GFButton(
                  onPressed: () {},
                  text: tAcceptThai,
                  color: hexToColor(primaryCodeColor),
                  textStyle: TextStyle(
                    color: hexToColor(codeColorBlack),
                    fontSize: 15,
                  ),
                  shape: GFButtonShape.pills,
                ),
              ),
              Container(
                child: GFButton(
                  onPressed: () {},
                  color: Colors.transparent,
                  text: tDeclineThai,
                  shape: GFButtonShape.pills,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
