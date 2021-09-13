import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rodsiaapp/request_service_feature/widgets/alertPopupCancleRequest.dart';

class CardWaitForGarage extends StatefulWidget {
  CardWaitForGarage({Key? key}) : super(key: key);

  @override
  _CardWaitForGarageState createState() => _CardWaitForGarageState();
}

class _CardWaitForGarageState extends State<CardWaitForGarage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: cardWidthMedium,
            decoration: BoxDecoration(
              borderRadius: borderRadiusMedium,
              boxShadow: [boxShadow],
              color: bgColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(defualtPaddingHight),
              child: Column(
                children: [
                  Text(
                    tWaitForGarageThai,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: defualtPaddingMedium,
                  ),
                  SpinKitPouringHourGlass(
                    color: primaryColor,
                    duration: Duration(milliseconds: 2000),
                  ),
                  SizedBox(
                    height: defualtPaddingHight,
                  ),
                  Container(
                      height: buttonHeightSmall,
                      width: buttonWidthSmall,
                      child: TextButton(
                        onPressed: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertPopupCancleReq());
                        },
                        child: Text(tCancleThai),
                        style: flatButtonStyle(primaryColor, textColorBlack),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
