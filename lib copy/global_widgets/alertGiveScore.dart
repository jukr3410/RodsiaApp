import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class AlertGiveScore extends StatefulWidget {
  AlertGiveScore({Key? key}) : super(key: key);

  @override
  _AlertGiveScoreState createState() => _AlertGiveScoreState();
}

class _AlertGiveScoreState extends State<AlertGiveScore> {
  double _rating = 0;

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
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  tGiveScore,
                  style: TextStyle(fontSize: fontSizeL),
                ),
                SizedBox(height: 5),
                GFRating(
                  color: primaryColor,
                  borderColor: primaryColor,
                  value: _rating,
                  onChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  cursorColor: primaryColor,
                  scrollPadding: EdgeInsets.only(top: 10),
                  maxLines: 3,
                  style: const TextStyle(
                      color: textColorBlack, fontSize: fontSizeS),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                      labelText: tMoreInfoThai,
                      alignLabelWithHint: true,
                      fillColor: Colors.red,
                      contentPadding: EdgeInsets.all(defualtPaddingLow),
                      labelStyle:
                          TextStyle(fontSize: fontSizeS, color: textColorBlack),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: hexToColor('#C4C4C4'), width: 0),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                ),
                SizedBox(height: 15),
                Container(
                  height: buttonHeightSmall,
                  width: buttonWidthSmall,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(tSend),
                    style: flatButtonStyle(primaryColor, textColorBlack),
                  ),
                ),
                GFButton(
                  onPressed: () {},
                  child: Text(tNotAtMoment),
                  color: textColorBlack,
                  type: GFButtonType.transparent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
