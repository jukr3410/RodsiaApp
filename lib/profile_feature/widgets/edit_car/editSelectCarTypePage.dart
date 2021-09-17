import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPleaseInputInfo.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectMoreChoice.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/showInfoNewCar.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editCarModel.dart';

class EditSelectCarTypePage extends StatefulWidget {
  final EditCarNoNewCar car;
  EditSelectCarTypePage({Key? key, required this.car}) : super(key: key);

  @override
  _EditSelectCarTypePageState createState() => _EditSelectCarTypePageState();
}

class _EditSelectCarTypePageState extends State<EditSelectCarTypePage> {
  String brand = tSelectBrandCar;
  String model = tSelectModelCar;
  String yearModel = '';
  String fuelType = tSelectFeulTypeCar;

  Car editCar = Car(
      id: '',
      brand: tSelectBrandCar,
      model: tSelectModelCar,
      type: 'car-null',
      year: '',
      fuelType: tSelectFeulTypeCar);

  void setStateCarType(int item) {
    setState(() {
      editCar.type = vehicleType[item].toString();
      print(editCar.type.toString());
    });
  }

  TextStyle styleTitleInfo = TextStyle(fontSize: fontSizeL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          tEditCar + 'คันที่: ' + widget.car.index.toString(),
          style: TextStyle(color: textColorBlack),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 6,
            child: Column(
              children: [
                _showInfoNewCar(),
              ],
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              children: [_selectVehicleType(), _buttonNext()],
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
            if (editCar.type == 'car-null') {
              return _showDialog(context);
            }
            print(editCar.type);
            navigatorToNextSelect();
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertPleaseInputInfo();
      },
    );
  }

  void navigatorToNextSelect() {
    Navigator.pushNamed(context, EDITCAR_MORECHOICE_ROUTE,
        arguments: EditCarAndIndex(
            carOld: widget.car.carOld,
            carNew: editCar,
            indexCar: widget.car.index));
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
              child: _infoTextOfBrandNewCar(tBrand, editCar.brand),
            ),
            Image.asset(
              tImageAsset(editCar.type),
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
                        _infoTextOfNewCar(tModel, editCar.model),
                        _infoTextOfNewCar('', editCar.year),
                      ],
                    ),
                    _infoTextOfNewCar(tFuelType, editCar.fuelType),
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

// selec tVehicle Type
  Widget _selectVehicleType() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tSelectVehicleTypeCar, style: styleTitleInfo),
          SizedBox(
            height: 10,
          ),
          _buttonIconType()
        ],
      ),
    );
  }

  Widget _buttonIconType() {
    return GridView.count(
      childAspectRatio: (2 / 0.9),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(vehicleType.length, (index) {
        return _listItemTypeCar(index);
      }),
    );
  }

  Widget _listItemTypeCar(int typeCar) {
    return Column(
      children: [
        FlatButton(
          child: Column(
            children: [
              Image.asset(
                tImageAsset(vehicleType[typeCar].toString()),
                width: 50,
              ),
              Text(vehicleType[typeCar].toString())
            ],
          ),
          onPressed: () {
            setStateCarType(typeCar);
          },
        ),
      ],
    );
  }
}
