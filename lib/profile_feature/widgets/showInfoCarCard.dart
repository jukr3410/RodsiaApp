import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';

class ShowInfoCarCard extends StatefulWidget {
  Car car;
  ShowInfoCarCard({Key? key, required this.car}) : super(key: key);

  @override
  _ShowInfoCarCardState createState() => _ShowInfoCarCardState();
}

class _ShowInfoCarCardState extends State<ShowInfoCarCard> {
  String brand = tSelectBrandCar;
  String model = tSelectModelCar;
  String yearModel = '';
  String fuelType = tSelectFeulTypeCar;
  String regisNumber = 'ป้ายทะเบียน';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              right: defualtPaddingMedium,
              left: defualtPaddingMedium,
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: _infoTextOfBrandNewCar(tBrand, widget.car.brand)),
                Expanded(
                    flex: 4,
                    child: Text(
                      widget.car.regisNumber,
                      textAlign: TextAlign.end,
                    ))
              ],
            ),
          ),
          Image.asset(
            tImageAsset(widget.car.type),
            width: 120,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: borderRadiusMediumOnlyBottom,
                color: primaryColor),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: defualtPaddingMedium,
                  top: defualtPaddingLow - 5,
                  bottom: defualtPaddingLow - 5),
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
    );
  }

  Widget _infoTextOfBrandNewCar(String title, String info) {
    return Row(
      children: [
        Text(
          title,
          // style: TextStyle(fontSize: fontSizeL),
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          info,
          // style: TextStyle(fontSize: fontSizeL),
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
}
