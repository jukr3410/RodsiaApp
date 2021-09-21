import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class DetailAndGiveStarPage extends StatefulWidget {
  DetailAndGiveStarPage({Key? key}) : super(key: key);

  @override
  _DetailAndGiveStarPageState createState() => _DetailAndGiveStarPageState();
}

class _DetailAndGiveStarPageState extends State<DetailAndGiveStarPage> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Container(
          alignment: Alignment.centerRight,
          child: GFButton(
            type: GFButtonType.transparent,
            textStyle: TextStyle(
                fontSize: 14, color: textColorBlack, fontFamily: 'Kanit'),
            child: Text(tSupportThai),
            onPressed: () {},
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingLow),
          child: Form(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 60,
                  child: ClipOval(
                    child: Image.asset(
                      tImageAsset('profile'),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  'RodSia Garage',
                  style: TextStyle(fontSize: fontSizeXl),
                ),
                Text(
                  tGiveScore,
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
                Padding(
                  padding: const EdgeInsets.all(defualtPaddingMedium),
                  child: TextFormField(
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
                        labelStyle: TextStyle(
                            fontSize: fontSizeS, color: textColorBlack),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: hexToColor('#C4C4C4'), width: 0),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: defualtPaddingMedium),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'บริการที่ใช้:',
                                      style: TextStyle(
                                          fontSize: fontSizeL,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Service type',
                                    ),
                                    Text('Service'),
                                    Text(
                                      tMoreInfoThai,
                                      softWrap: true,
                                      maxLines: 3,
                                    ),
                                    Text('เวลา'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'สถานที่: ',
                                      style: TextStyle(
                                          fontSize: fontSizeL,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '23456 แขวงนู่น เขตนี่',
                                      softWrap: true,
                                      maxLines: 3,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(height: 20),
                Container(
                  height: buttonHeightSmall + 5,
                  width: buttonWidthLarge,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(tSend),
                    style: flatButtonStyle(primaryColor, textColorBlack),
                  ),
                ),
                GFButton(
                  onPressed: () {},
                  child: Text(tBackToHomePage),
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