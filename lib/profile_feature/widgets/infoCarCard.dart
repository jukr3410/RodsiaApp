import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

class InfoCarCard extends StatefulWidget {
  InfoCarCard({Key? key}) : super(key: key);

  @override
  _InfoCarCardState createState() => _InfoCarCardState();
}

class _InfoCarCardState extends State<InfoCarCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: defualtPaddingMedium,
      ),
      height: 355,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: trackingStatus.length,
          itemBuilder: (context, index) {
            return Container(
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: borderRadiusMedium),
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.all(defualtPaddingMedium),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'รถคันที่: ${index + 1}',
                          style: TextStyle(fontSize: fontSizeXl),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          tImageAsset("carTest"),
                          width: 300,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [Text(tBrand), Text("Honda")],
                        ),
                        Row(
                          children: [
                            Text(tModel),
                            Text("Civic" + '-' + '2020')
                          ],
                        ),
                        Row(
                          children: [Text(tFuelType), Text("Gas")],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: buttonWidthSmall,
                              height: buttonHeightSmall,
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: borderRadiusMedium),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    tEdit,
                                    style: TextStyle(color: textColorBlack),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GFButton(
                                onPressed: () {},
                                type: GFButtonType.transparent,
                                child: Text(
                                  tRemove,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: textColorRed),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
