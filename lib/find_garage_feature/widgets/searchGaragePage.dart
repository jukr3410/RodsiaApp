import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/search_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageList.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/main.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: ImageIcon(
                        AssetImage(tImageAsset('backPage')),
                        size: 14,
                      ),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Expanded(
                    child: Container(
                      height: 30,
                      child: TextField(
                        // onSubmitted: (String value) {
                        //   setState(() {
                        //     search = value;
                        //     logger.d(value);
                        //   });
                        // },
                        autofocus: true,
                        controller: _controller,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 2.0),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20,
                            ),
                            filled: true,
                            focusColor: primaryColor,
                            fillColor: textColorWhite,
                            border: OutlineInputBorder(
                              borderRadius: borderRadiusMedium,
                            ),
                            hintText: 'ค้นหาร้านซ้อมรถ',
                            hintStyle: TextStyle(
                                color: hexToColor("#C4C4C4"), fontSize: 12)),
                      ),
                    ),
                  ),
                  GFButton(
                    onPressed: () {
                      navigatorToListGarage(_controller.text);
                    },
                    child: Text(tSearch),
                    type: GFButtonType.transparent,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigatorToListGarage(String garageName) {
    Navigator.pushNamed(context, GARAGE_SEARCH_ROUTE, arguments: garageName);
  }
}
