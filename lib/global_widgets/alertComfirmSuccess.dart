import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

class AlertComfirmSuccess extends StatefulWidget {
  AlertComfirmSuccess({Key? key}) : super(key: key);

  @override
  _AlertComfirmSuccessState createState() => _AlertComfirmSuccessState();
}

class _AlertComfirmSuccessState extends State<AlertComfirmSuccess> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidth,
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
                tConfirmSuccessThai,
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
