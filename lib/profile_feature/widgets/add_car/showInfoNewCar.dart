import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';

import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';

class ShowInfoNewCar extends StatefulWidget {
  Car car;
  ShowInfoNewCar({Key? key, required this.car}) : super(key: key);

  @override
  _ShowInfoNewCarState createState() => _ShowInfoNewCarState();
}

class _ShowInfoNewCarState extends State<ShowInfoNewCar> {
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
                tInfoNewcar,
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
                            'รถคันที่: ${widget.car.id}',
                            style: TextStyle(fontSize: fontSizeXl),
                            textAlign: TextAlign.right,
                          ),
                          Image.asset(
                            tImageAsset(widget.car.type),
                            alignment: Alignment.center,
                            width: 250,
                          ),
                          Row(
                            children: [Text(tBrand), Text(widget.car.brand)],
                          ),
                          Row(
                            children: [
                              Text(tModel),
                              Text(widget.car.model + ' ' + widget.car.year)
                            ],
                          ),
                          Row(
                            children: [
                              Text(tFuelType),
                              Text(widget.car.fuelType)
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
      mockUpUser.cars!.add(widget.car);
      navigatorToAddCar();
    }
  }

  void navigatorToBlack() {
    Navigator.pop(context);
  }

  void navigatorToAddCar() {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: mockUpUser);
  }
}
