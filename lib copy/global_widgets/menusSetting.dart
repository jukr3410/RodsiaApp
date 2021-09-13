import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';

class MenusSetting extends StatefulWidget {
  MenusSetting({Key? key}) : super(key: key);

  @override
  _MenusSettingState createState() => _MenusSettingState();
}

class _MenusSettingState extends State<MenusSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.yellow.shade800,
            Colors.yellow.shade400,
            Colors.yellow.shade50
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 70,
              child: ClipOval(
                child: Image.asset(
                  tImageAsset('profile'),
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'ทศภูมิ เกียรติดำรงพร',
              style: TextStyle(fontSize: fontSizeL),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: borderRadiusHightOnlyTop, color: bgColor),
                  child: Padding(
                      padding: const EdgeInsets.all(defualtPaddingHight),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.grey.shade400,
                          ))),
                          child: Column(
                            children: [
                              _TextButtonManus(menusSetting[0], PROFILE_ROUTE),
                              _TextButtonManus(menusSetting[1], PROFILE_ROUTE),
                              _TextButtonManus(menusSetting[2], PROFILE_ROUTE),
                              _TextButtonManus(menusSetting[3], PROFILE_ROUTE),
                            ],
                          ))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _TextButtonManus(String name, String route) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 35,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            child: (Text(
              name,
              style: TextStyle(
                fontSize: fontSizeM,
                color: textColorBlack,
              ),
            )),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
