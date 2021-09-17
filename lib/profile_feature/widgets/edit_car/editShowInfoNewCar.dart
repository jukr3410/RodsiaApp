import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editCarModel.dart';

class EditShowInfoNewCar extends StatefulWidget {
  EditCarAndIndex car;
  EditShowInfoNewCar({Key? key, required this.car}) : super(key: key);

  @override
  _EditShowInfoNewCarState createState() => _EditShowInfoNewCarState();
}

class _EditShowInfoNewCarState extends State<EditShowInfoNewCar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.yellow.shade800,
            Colors.yellow.shade400,
            Colors.yellow.shade50
          ])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: textColorBlack,
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tInfoEditcar,
                style: TextStyle(fontSize: fontSizeXl + 5),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 290,
                child: Card(
                  shape:
                      RoundedRectangleBorder(borderRadius: borderRadiusMedium),
                  color: bgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(defualtPaddingMedium),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'แก้ไขรถคันที่: ${widget.car.indexCar}',
                            style: TextStyle(fontSize: fontSizeXl),
                            textAlign: TextAlign.right,
                          ),
                          Image.asset(
                            tImageAsset(widget.car.carNew.type),
                            alignment: Alignment.center,
                            width: 250,
                          ),
                          Row(
                            children: [
                              Text(tBrand),
                              Text(widget.car.carNew.brand)
                            ],
                          ),
                          Row(
                            children: [
                              Text(tModel),
                              Text(widget.car.carNew.model +
                                  ' ' +
                                  widget.car.carNew.year)
                            ],
                          ),
                          Row(
                            children: [
                              Text(tFuelType),
                              Text(widget.car.carNew.fuelType)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: buttonWidthSmall,
                height: buttonHeightSmall,
                decoration: BoxDecoration(
                    color: textColorBlack, borderRadius: borderRadiusMedium),
                child: TextButton(
                    onPressed: () {
                      _navigateAndDisplaySelection(context);
                    },
                    child: Text(
                      tOKThai,
                      style: TextStyle(color: primaryColor),
                    )),
              ),
              SizedBox(
                width: 5,
              ),
              GFButton(
                  onPressed: () {
                    navigatorToBlack();
                  },
                  type: GFButtonType.transparent,
                  child: Text(
                    tEdit,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: textColorRed),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tUpdateTrackingStatus));
    if (result == 'Ok') {
      mockUpUser.cars[widget.car.indexCar - 1] = widget.car.carNew;
      navigatorToEditCar();
    }
  }

  void navigatorToBlack() {
    Navigator.pop(context);
  }

  void navigatorToEditCar() {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: mockUpUser);
  }
}
