import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

class SupportButton extends StatefulWidget {
  const SupportButton({Key? key}) : super(key: key);

  @override
  _SupportButtonState createState() => _SupportButtonState();
}

class _SupportButtonState extends State<SupportButton> {
  @override
  Widget build(BuildContext context) {
    return GFButton(
      type: GFButtonType.transparent,
      textStyle: TextStyle(fontSize: 14, color: textColorBlack),
      child: Text(tSupportThai),
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertShowContactSupport());
    if (result == 'Ok') {
      Navigator.pop(context);
    }
  }

  Widget AlertShowContactSupport() {
    return Center(
      child: Container(
        width: cardWidthLow,
        decoration: BoxDecoration(
          borderRadius: borderRadiusLow,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingLow),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'ติดต่อช่วยเหลือ:',
                  style: TextStyle(
                      fontSize: fontSizeL,
                      fontWeight: FontWeight.bold,
                      color: textColorBlack),
                ),
              ),
              Row(
                children: [
                  Image.asset(tImageAsset('email-support')),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email: ',
                        style: TextStyle(fontSize: fontSizeL),
                      ),
                      Text(
                        'asdfoiahjsdf@mail.com',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Image.asset(tImageAsset('phone-support')),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone: ',
                        style: TextStyle(fontSize: fontSizeL),
                      ),
                      Text(
                        '546-46464565',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  )
                ],
              ),
              // Text(
              //   widget.datail,
              //   style: TextStyle(
              //       fontSize: fontSizeL,
              //       color: textColorBlack,
              //       fontWeight: FontWeight.w500,
              //       fontFamily: 'Kanit'),
              // ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    height: buttonHeightSmall - 10,
                    width: buttonWidthSmall - 20,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(tOKThai),
                      style: flatButtonStyle(primaryColor, textColorBlack),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
