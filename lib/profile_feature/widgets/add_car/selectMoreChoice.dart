import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPleaseInputInfo.dart';

class SelectMoreChoice extends StatefulWidget {
  Car car;
  SelectMoreChoice({Key? key, required this.car}) : super(key: key);

  @override
  _SelectMoreChoiceState createState() => _SelectMoreChoiceState();
}

class _SelectMoreChoiceState extends State<SelectMoreChoice> {
  String brand = tSelectBrandCar;
  String model = tSelectModelCar;
  String yearModel = '';
  String fuelType = tSelectFeulTypeCar;

  String? valueBrand;
  String? valueModel;
  String? valueYear;
  String? valueFuelType;

  void setStateBrand(Object? item) {
    setState(() {
      valueBrand = item.toString();
      widget.car.brand = item.toString();
    });
  }

  void setStateModel(Object? item) {
    setState(() {
      valueModel = item.toString();
      widget.car.model = item.toString();
    });
  }

  void setStateYear(Object? item) {
    setState(() {
      valueYear = item.toString();
      widget.car.year = item.toString();
    });
  }

  void setStateFuelType(Object? item) {
    setState(() {
      valueFuelType = item.toString();
      widget.car.fuelType = item.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          tAddCar,
          style: TextStyle(color: textColorBlack),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 5,
            child: Column(
              children: [
                _showInfoNewCar(),
              ],
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              children: [
                _selectDropdownBrand(tBrand, brandCar),
                _selectDropdownModel(tModel, modelCar),
                _selectDropdownYear(tYearModel, yearModelCar),
                _selectDropdownFuelType(tFuelType, fuelTypeCar),
                SizedBox(
                  height: 20,
                ),
                _buttonNext()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buttonNext() {
    return Container(
      width: buttonWidthSmall,
      height: buttonHeightSmall,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: borderRadiusMedium,
      ),
      child: TextButton(
          onPressed: () {
            if (widget.car.brand == brand ||
                widget.car.model == model ||
                widget.car.year == yearModel ||
                widget.car.fuelType == fuelType) {
              return _showDialog(context);
            } else {
              navigatorToSelectFuelType();
              print(widget.car.toJson());
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tNext,
                style: TextStyle(color: textColorBlack),
              ),
              Icon(
                Icons.navigate_next,
                color: textColorBlack,
              )
            ],
          )),
    );
  }

  void navigatorToSelectFuelType() {
    Navigator.pushNamed(context, ADDCAR_SHOWINFO_NEWCAR_ROUTE,
        arguments: widget.car);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertPleaseInputInfo();
      },
    );
  }

// show info new car
  Widget _showInfoNewCar() {
    return Padding(
      padding: const EdgeInsets.all(defualtPaddingMedium),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: defualtPaddingLow,
                left: defualtPaddingMedium,
              ),
              child: _infoTextOfBrandNewCar(tBrand, widget.car.brand),
            ),
            Image.asset(
              tImageAsset(widget.car.type),
              width: 180,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: borderRadiusMediumOnlyBottom,
                  color: primaryColor),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: defualtPaddingMedium,
                    top: defualtPaddingLow,
                    bottom: defualtPaddingLow),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        _infoTextOfNewCar(tModel, widget.car.model),
                        _infoTextOfNewCar('', widget.car.year),
                      ],
                    ),
                    _infoTextOfNewCar(tFuelType, widget.car.fuelType),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoTextOfBrandNewCar(String title, String info) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: fontSizeXl),
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          info,
          style: TextStyle(fontSize: fontSizeXl),
        )
      ],
    );
  }

  Widget _infoTextOfNewCar(String title, String info) {
    return Row(
      children: [
        Text(
          title,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          info,
        )
      ],
    );
  }

// select dropdown
  Widget _selectDropdownBrand(String titleInfoText, List<String> list) {
    return Padding(
      padding: const EdgeInsets.only(
          right: defualtPaddingHight + 5, left: defualtPaddingHight + 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(titleInfoText),
          Container(
            height: buttonHeightSmall,
            width: buttonWidthMedium,
            margin: EdgeInsets.all(defualtPaddingLow - 5),
            child: DropdownButtonHideUnderline(
              child: GFDropdown(
                value: valueBrand,
                padding: const EdgeInsets.all(defualtPaddingLow),
                borderRadius: borderRadiusLow,
                border: const BorderSide(color: Colors.black12, width: 1),
                dropdownButtonColor: bgColor,
                onChanged: (value) {
                  setStateBrand(value);
                },
                items: list.map(buildMenuItem).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectDropdownModel(String titleInfoText, List<String> list) {
    return Padding(
      padding: const EdgeInsets.only(
          right: defualtPaddingHight + 5, left: defualtPaddingHight + 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(titleInfoText),
          Container(
            height: buttonHeightSmall,
            width: buttonWidthMedium,
            margin: EdgeInsets.all(defualtPaddingLow - 5),
            child: DropdownButtonHideUnderline(
              child: GFDropdown(
                value: valueModel,
                padding: const EdgeInsets.all(defualtPaddingLow),
                borderRadius: borderRadiusLow,
                border: const BorderSide(color: Colors.black12, width: 1),
                dropdownButtonColor: bgColor,
                onChanged: (value) {
                  setStateModel(value);
                },
                items: list.map(buildMenuItem).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectDropdownYear(String titleInfoText, List<String> list) {
    return Padding(
      padding: const EdgeInsets.only(
          right: defualtPaddingHight + 5, left: defualtPaddingHight + 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(titleInfoText),
          Container(
            height: buttonHeightSmall,
            width: buttonWidthMedium,
            margin: EdgeInsets.all(defualtPaddingLow - 5),
            child: DropdownButtonHideUnderline(
              child: GFDropdown(
                value: valueYear,
                padding: const EdgeInsets.all(defualtPaddingLow),
                borderRadius: borderRadiusLow,
                border: const BorderSide(color: Colors.black12, width: 1),
                dropdownButtonColor: bgColor,
                onChanged: (value) {
                  setStateYear(value);
                },
                items: list.map(buildMenuItem).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectDropdownFuelType(String titleInfoText, List<String> list) {
    return Padding(
      padding: const EdgeInsets.only(
          right: defualtPaddingHight + 5, left: defualtPaddingHight + 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(titleInfoText),
          Container(
            height: buttonHeightSmall,
            width: buttonWidthMedium,
            margin: EdgeInsets.all(defualtPaddingLow - 5),
            child: DropdownButtonHideUnderline(
              child: GFDropdown(
                value: valueFuelType,
                padding: const EdgeInsets.all(defualtPaddingLow),
                borderRadius: borderRadiusLow,
                border: const BorderSide(color: Colors.black12, width: 1),
                dropdownButtonColor: bgColor,
                onChanged: (value) {
                  setStateFuelType(value);
                },
                items: list.map(buildMenuItem).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(),
        ),
      );
}
