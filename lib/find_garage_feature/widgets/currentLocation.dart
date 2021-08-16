import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class CurrentLocation extends StatefulWidget {
  CurrentLocation({Key? key}) : super(key: key);

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadiusLow,
            boxShadow: [boxShadow],
          ),
          child: IconButton(
            icon: ImageIcon(
              AssetImage("image/icon-location.png"),
              size: 28,
            ),
            color: hexToColor(codeColorBlack),
            onPressed: () {},
          ),
        ));
  }
}
