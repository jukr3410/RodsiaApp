import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

class ButtonRequestService extends StatefulWidget {
  ButtonRequestService({Key? key}) : super(key: key);

  @override
  _ButtonRequestServiceState createState() => _ButtonRequestServiceState();
}

class _ButtonRequestServiceState extends State<ButtonRequestService> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidthMedium,
      height: buttonHeightMedium,
      child: TextButton(
        onPressed: () {},
        style: flatButtonStyle(primaryColor, textColorBlack),
        child: Text(tRequestServiceThai),
      ),
    );
  }
}
