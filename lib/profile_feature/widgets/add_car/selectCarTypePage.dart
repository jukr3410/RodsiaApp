import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPleaseInputInfo.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/selectMoreChoice.dart';
import 'package:rodsiaapp/profile_feature/widgets/add_car/showInfoNewCar.dart';
import 'package:rodsiaapp/profile_feature/widgets/showInfoCarCard.dart';

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
    brand: tSelectBrandCar,
    model: tSelectModelCar,
    type: 'car-null',
    year: '',
    fuelType: tSelectFeulTypeCar,
    regisNumber: '',
  );

  void setStateCarType(int item) {
    setState(() {
      newCar.type = vehicleType[item].toString();
      print(newCar.type.toString());
    });
  }

  TextStyle styleTitleInfo = TextStyle(fontSize: fontSizeL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: textColorBlack),
        backgroundColor: primaryColor,
        title: Text(
          tAddCar,
          style: TextStyle(color: textColorBlack),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColorBlack),
          onPressed: () => navigatorToProfilePage(),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defualtPaddingMedium),
                child: ShowInfoCarCard(car: newCar),
              ),
              SizedBox(
                height: 30,
              ),
              _selectVehicleType(),
              SizedBox(
                height: 30,
              ),
              _buttonNext()
            ],
          ),
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
            if (newCar.type == 'car-null') {
              return _showDialog(context);
            }
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertPleaseInputInfo();
      },
    );
  }

  void navigatorToNextSelect() {
    Navigator.pushNamed(context, ADDCAR_MORECHOICE_ROUTE, arguments: newCar);
  }

// selec tVehicle Type
  Widget _selectVehicleType() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tSelectVehicleTypeCar, style: styleTitleInfo),
          SizedBox(
            height: 20,
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
          color: newCar.type == vehicleType[typeCar]
              ? primaryColor
              : Colors.transparent,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(defualtPaddingLow)),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Image.asset(
                  tImageAsset(vehicleType[typeCar].toString()),
                  width: 50,
                ),
                Text(vehicleType[typeCar].toString())
              ],
            ),
          ),
          onPressed: () {
            setStateCarType(typeCar);
          },
        ),
      ],
    );
  }

  void navigatorToProfilePage() {
    Navigator.pushNamed(context, PROFILE_ROUTE, arguments: widget.user);
  }
}
