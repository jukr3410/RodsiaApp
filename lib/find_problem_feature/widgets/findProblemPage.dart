import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/main.dart';

class FindProblemPage extends StatefulWidget {
  FindProblemPage({Key? key}) : super(key: key);

  @override
  _FindProblemPageState createState() => _FindProblemPageState();
}

class _FindProblemPageState extends State<FindProblemPage> {
  TextStyle styleTitleInfo = TextStyle(fontSize: fontSizeL);
  int typeForFindProblem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('ค้นหาปัญหาของรถ'),
        titleTextStyle: TextStyle(
            color: textColorBlack, fontSize: fontSizeXl, fontFamily: 'Kanit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defualtPaddingLow),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "เลือกถึงปัญหาที่สังเกตุได้",
            ),
            SizedBox(
              height: 5,
            ),
            _buttonIconType()
          ],
        ),
      ),
    );
  }

  Widget _buttonIconType() {
    return GridView.count(
      childAspectRatio: (2 / 1.12),
      crossAxisCount: 2,
      crossAxisSpacing: 7,
      shrinkWrap: true,
      children: List.generate(mockupFindProblem.length, (index) {
        return _listItemTypeCar(index);
      }),
    );
  }

  Widget _listItemTypeCar(int typeCar) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: FlatButton(
            color: Colors.grey.shade200,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(defualtPaddingLow)),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      tImageAsset(mockupNameFindProblem[typeCar].toString()),
                      height: 50,
                      color: textColorBlack,
                    ),
                  ),
                  Text(
                    mockupFindProblem[typeCar].toString(),
                    style: TextStyle(fontSize: fontSizeS + 1),
                  )
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                typeForFindProblem = typeCar;
                logger.d(typeForFindProblem);
                logger.d(mockupFindProblem[typeCar]);
                navigatorToFindProblemPage();
              });
            },
          ),
        ),
      ],
    );
  }

  void navigatorToFindProblemPage() {
    Navigator.pushNamed(context, FIND_PROBLEM, arguments: typeForFindProblem);
  }
}
