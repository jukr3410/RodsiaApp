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
    return Center(
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(image: AssetImage('image/icon-battery-service.png')),
              SizedBox(height: 20),
              Text(
                tAlertRequestService,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ชื่อ: '),
                  Text('XXXXXXXX'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ยานภาหนะ: '),
                  Text('Honda Civic 1.6L'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('บริการ: '),
                  Text('แบตเตอรี่'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ระยะทาง: '),
                  Text('2.5 กิโลเมตร'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('รายละเอียดเพื่มเติม: '),
                  Flexible(
                      child: Text(
                    'xxxxxxxxxxxxx',
                    softWrap: true,
                  )),
                ],
              ),
              SizedBox(height: defualtPaddingMedium),
              Container(
                height: buttonHeightMedium,
                width: double.infinity,
                child: GFButton(
                  onPressed: () {},
                  text: tCallbackForMoreInfo,
                  color: hexToColor(primaryCodeColor),
                  textStyle: TextStyle(
                    color: hexToColor(codeColorBlack),
                    fontSize: 15,
                  ),
                  shape: GFButtonShape.pills,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GFButton(
                    onPressed: () {},
                    color: Colors.transparent,
                    text: tRequestServiceThai,
                    type: GFButtonType.transparent,
                  ),
                  GFButton(
                    onPressed: () {},
                    color: textColorRed,
                    text: tDeclineThai,
                    type: GFButtonType.transparent,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
