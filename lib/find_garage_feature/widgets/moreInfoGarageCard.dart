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
          height: 110,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ImageIcon(
                        AssetImage('image/icon-location.png'),
                        size: 32,
                      ),
                    ),
                    Flexible(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                        bottom: 10,
                      ),
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
              Container(
                height: 33,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "ดูรายละเอียดเพิ่มเติม",
                    style: TextStyle(
                        fontSize: 12, color: hexToColor(codeColorBlack)),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          hexToColor(primaryCodeColor)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
                ),
              )
            ],
          )),
    );
  }
}
