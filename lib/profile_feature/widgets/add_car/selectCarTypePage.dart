import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/SelectBrandModelYear.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/showInfoNewCar.dart';

class SelectCarTypePage extends StatefulWidget {
  final User user;
  SelectCarTypePage({Key? key, required this.user}) : super(key: key);

  @override
  _SelectCarTypePageState createState() => _SelectCarTypePageState();
}

class _SelectCarTypePageState extends State<SelectCarTypePage> {
  String brand = tSelectBrandCar;
  String model = tSelectModelCar;
  String yearModel = '';
  String fuelType = tSelectFeulTypeCar;

  Car newCar = Car(
      id: '',
      brand: tSelectBrandCar,
      model: tSelectModelCar,
      type: 'car-null',
      year: '',
      fuelType: tSelectFeulTypeCar);

  void setStateCarType(int item) {
    setState(() {
      newCar.type = vehicleType[item].toString();
      print(newCar.type.toString());
    });
  }

  void setStateBrand(String item) {
    setState(() {
      brand = item;
    });
  }

  void setStatemodel(String item) {
    setState(() {
      model = item;
    });
  }

  void setStateYearModel(String item) {
    setState(() {
      yearModel = item;
    });
  }

  void setStateFuelType(String item) {
    setState(() {
      fuelType = item;
    });
  }

  TextStyle styleTitleInfo = TextStyle(fontSize: fontSizeL);

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
            flex: 3,
            child: Column(
              children: [
                _selectVehicleType(),
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
            newCar.id = (widget.user.cars.length + 1).toString();
            print(newCar.toJson());
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

  void navigatorToNextSelect() {
    Navigator.pushNamed(context, ADDCAR_BRANDMODELYEAR_ROUTE,
        arguments: newCar);
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
              child: _infoTextOfBrandNewCar(tBrand, newCar.brand),
            ),
            Image.asset(
              tImageAsset(newCar.type),
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
                        _infoTextOfNewCar(tModel, newCar.model),
                        _infoTextOfNewCar('', newCar.year),
                      ],
                    ),
                    _infoTextOfNewCar(tFuelType, newCar.fuelType),
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
      childAspectRatio: (2 / 1.1),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(widget.user.cars.length + 1, (index) {
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
                width: 80,
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
