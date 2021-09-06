import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/request_service_feature/widgets/cardWaitForGarage.dart';

class WaitForGaragePage extends StatefulWidget {
  WaitForGaragePage({Key? key}) : super(key: key);

  @override
  _WaitForGaragePageState createState() => _WaitForGaragePageState();
}

class _WaitForGaragePageState extends State<WaitForGaragePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
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
      body: CardWaitForGarage(),
    );
  }
}
