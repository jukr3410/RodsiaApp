import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

class AlertPopupCancleReq extends StatefulWidget {
  AlertPopupCancleReq({Key? key}) : super(key: key);

  @override
  _AlertPopupCancleReqState createState() => _AlertPopupCancleReqState();
}

class _AlertPopupCancleReqState extends State<AlertPopupCancleReq> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidthMedium,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tYouWantCancleThai,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: defualtPaddingMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: buttonHeightSmall,
                      width: buttonWidthSmall,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                        },
                        child: Text(tOKThai),
                        style: flatButtonStyle(primaryColor, textColorBlack),
                      )),
                  GFButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: Text(tCancleThai),
                    textColor: textColorBlack,
                    type: GFButtonType.transparent,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
