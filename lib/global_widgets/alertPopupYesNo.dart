import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:rodsiaapp/constants.dart';

class AlertPopupYesNo extends StatelessWidget {
  final String title;
  const AlertPopupYesNo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: cardWidthLow,
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
                  title,
                  style: TextStyle(
                      fontSize: fontSizeL,
                      color: textColorBlack,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kanit'),
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
                            Navigator.pop(context, 'Ok');
                          },
                          child: Text(tOKThai),
                          style: flatButtonStyle(primaryColor, textColorBlack),
                        )),
                    GFButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancal');
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
      ),
    );
  }
}
