import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class MoreInfoGarageCard extends StatefulWidget {
  MoreInfoGarageCard({Key? key}) : super(key: key);

  @override
  _MoreinfogarageCardState createState() => _MoreinfogarageCardState();
}

class _MoreinfogarageCardState extends State<MoreInfoGarageCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          margin: EdgeInsets.only(bottom: 0, top: 20, right: 40, left: 40),
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 4,
                  offset: Offset(2, 4),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: ImageIcon(
                        AssetImage('image/icon-location.png'),
                        size: 32,
                      ),
                    ),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 3,),
                      child: Text(
                        "123/456 ถนนสวะประยุทธ์ แขวงประวิตร เขตเหี้ยป้อม กรุงเทพมหานคร 10150",
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 14, color: hexToColor(codeColorBlack)),
                      ),
                    )),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "ดูรายละเอียดเพิ่มเติม",
                  style: TextStyle(
                      fontSize: 12, color: hexToColor(codeColorBlack)),
                ),
                style: TextButton.styleFrom(
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    backgroundColor: hexToColor(primaryCodeColor)),
              )
            ],
          )),
    );
  }
}
