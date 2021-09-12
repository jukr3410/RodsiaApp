import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectVehicleTypeCard.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/showInfoNewCar.dart';

class SelectVehiclePage extends StatefulWidget {
  SelectVehiclePage({Key? key}) : super(key: key);

  @override
  _SelectVehiclePageState createState() => _SelectVehiclePageState();
}

class _SelectVehiclePageState extends State<SelectVehiclePage> {
  int numTypeCar = 4;
  String brand = tSelectBrandCar;
  String model = tSelectModelCar;
  String yearModel = tSelectYearModelCar;
  String fuelType = tSelectFeulTypeCar;

  void setStateCarType(int item) {
    setState(() {
      numTypeCar = item;
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
          _showInfoNewCar(),
          _selectVehicleType(),
          _selectDropdown(brand, brandCar),
          _selectDropdown(model, brandCar),
          _selectDropdown(brand, brandCar),
          _selectDropdown(brand, brandCar),
        ],
      ),
    );
  }

// show info new car
  Widget _showInfoNewCar() {
    return Padding(
      padding: const EdgeInsets.all(defualtPaddingMedium),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadiusLow,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: defualtPaddingLow,
                left: defualtPaddingLow,
              ),
              child: _infoTextOfNewCar(tBrand, brand),
            ),
            Image.asset(
              tImageAsset(vehicleType[numTypeCar].toString()),
              width: 130,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: borderRadiusLowOnlyBottom, color: primaryColor),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(defualtPaddingLow),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        _infoTextOfNewCar(tModel, model),
                        Text(yearModel,
                            style: TextStyle(
                              fontSize: fontSizeL,
                              fontWeight: FontWeight.bold,
                            ))
                      ],
                    ),
                    _infoTextOfNewCar(tFuelType, fuelType),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
          style: TextStyle(),
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
      childAspectRatio: (2 / .8),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(4, (index) {
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
            print(vehicleType[typeCar].toString());
          },
        ),
      ],
    );
  }

// select brand

  Widget _selectDropdown(String titleInfo, List<String> list) {
    List<String> newList = ['', ...list];
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
          items: newList
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ))
              .toList(),
        ),
      ),
    );
  }

  List<String> brandCar = ['Mazda', 'Honda', 'Yamaha', 'Toyota'];
}
