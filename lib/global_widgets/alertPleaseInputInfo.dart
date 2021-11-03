import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';

class AlertPleaseInputInfo extends StatefulWidget {
  AlertPleaseInputInfo({Key? key}) : super(key: key);

  @override
  _AlertPleaseInputInfoState createState() => _AlertPleaseInputInfoState();
}

class _AlertPleaseInputInfoState extends State<AlertPleaseInputInfo> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        tProblemThai,
      ),
      content: new Text(tPlearInputInfo),
      actions: <Widget>[
        FlatButton(
          color: primaryColor,
          textColor: textColorBlack,
          child: new Text(tOKThai),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
