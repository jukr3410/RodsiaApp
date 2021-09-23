import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class InfoGarageFormSelect extends StatefulWidget {
  Garage garage;
  InfoGarageFormSelect({Key? key, required this.garage}) : super(key: key);

  @override
  _InfoGarageFormSelectState createState() => _InfoGarageFormSelectState();
}

class _InfoGarageFormSelectState extends State<InfoGarageFormSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Image(image: AssetImage('image/image-garage-mockup.png')),
          Container(
            margin: EdgeInsets.only(
              top: 120,
              left: defualtPaddingHight,
              right: defualtPaddingHight,
            ),
            decoration: BoxDecoration(
              borderRadius: borderRadiusMedium,
              boxShadow: [boxShadow],
              color: bgColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(defualtPaddingMedium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "168 Garage - อู๋ซ้อมรถ",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('Rating: '),
                      // Image(
                      //   image: AssetImage('image/icon-star.png'),
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('4.5'),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: hexToColor(codeColorGray),
                    height: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(tAddressThai),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          '666 ถนนไม่มี แขวงแหม เขตจ้า กรุงเทพมหานคร 10000',
                          softWrap: true,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
