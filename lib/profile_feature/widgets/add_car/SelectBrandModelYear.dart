import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';

class SelectBrandModelYear extends StatefulWidget {
  Car car;
  SelectBrandModelYear({Key? key, required this.car}) : super(key: key);

  @override
  _SelectBrandModelYearState createState() => _SelectBrandModelYearState();
}

class _SelectBrandModelYearState extends State<SelectBrandModelYear> {
  String brand = tSelectBrandCar;
  String model = tSelectModelCar;
  String yearModel = '';
  String fuelType = tSelectFeulTypeCar;

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
            flex: 4,
            child: Column(
              children: [
                SizedBox(height: 20),
                _showInfoNewCar(),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Column(
              children: [
                _selectDropdown(brand, brandCar),
                // _selectDropdown(model, brandCar),
                // _selectDropdown(brand, brandCar),
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
          onPressed: () {},
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

  Widget _selectDropdown(String titleInfo, List<String> list) {
    return Container(
      height: buttonHeightSmall,
      width: buttonWidthMedium,
      margin: EdgeInsets.all(defualtPaddingLow - 5),
      child: DropdownButtonHideUnderline(
        child: GFDropdown(
          padding: const EdgeInsets.all(defualtPaddingLow),
          borderRadius: borderRadiusLow,
          border: const BorderSide(color: Colors.black12, width: 1),
          dropdownButtonColor: bgColor,
          value: titleInfo,
          onChanged: (newValue) {
            setState(() {
              titleInfo = newValue.toString();

              print(titleInfo);
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
