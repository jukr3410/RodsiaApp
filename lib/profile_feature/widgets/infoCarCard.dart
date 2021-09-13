import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';

class InfoCarCard extends StatefulWidget {
  final User user;
  InfoCarCard({Key? key, required this.user}) : super(key: key);

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
      height: 440,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.user.cars.length,
          itemBuilder: (context, index) {
            final _infoCar = widget.user.cars[index];
            return Container(
              width: 290,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: borderRadiusMedium),
                color: bgColor,
                child: Padding(
                  padding: const EdgeInsets.all(defualtPaddingMedium),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'รถคันที่: ${_infoCar.id}',
                          style: TextStyle(fontSize: fontSizeXl),
                          textAlign: TextAlign.right,
                        ),
                        Image.asset(
                          tImageAsset(_infoCar.type),
                          alignment: Alignment.center,
                          width: 230,
                        ),
                        Row(
                          children: [Text(tBrand), Text(_infoCar.brand)],
                        ),
                        Row(
                          children: [
                            Text(tModel),
                            Text(_infoCar.model + ' ' + _infoCar.year)
                          ],
                        ),
                        Row(
                          children: [Text(tFuelType), Text(_infoCar.fuelType)],
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
                              width: 5,
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

  void navigatorToEditCar(Car car, User user) {
    Navigator.pushNamed(context, EDITCAR_ROUTE, arguments: [car, user]);
  }

  void navigatorToDelete(Car car, User user) {
    Navigator.pushNamed(context, DELETECAR_ROUTE, arguments: [car, user]);
  }
}
