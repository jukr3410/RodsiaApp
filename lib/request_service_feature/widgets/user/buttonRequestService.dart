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
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: primaryColor,
    primary: Colors.black87,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: borderRadiusMedium,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 50,
      child: TextButton(
        onPressed: () {},
        style: flatButtonStyle,
        child: Text(tRequestServiceThai),
      ),
    );
    // Container(
    //   width: 250,
    //   child: GFButton(
    //     color: primaryColor,
    //     text: tRequestServiceThai,
    //     textColor: textColorBlack,
    //     shape: GFButtonShape.pills,
    //     size: GFSize.LARGE,
    //     onPressed: () {},
    //   ),
    // );
  }
}
