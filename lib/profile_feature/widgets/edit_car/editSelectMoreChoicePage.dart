import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:rodsiaapp/car_mockup.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPleaseInputInfo.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/widgets/edit_car/editCarModel.dart';
import 'package:rodsiaapp/profile_feature/widgets/showInfoCarCard.dart';

class EditSelectMoreChoice extends StatefulWidget {
  EditCarNoNewCar car;
  EditSelectMoreChoice({Key? key, required this.car}) : super(key: key);

  @override
  _EditSelectMoreChoiceState createState() => _EditSelectMoreChoiceState();
}

class _EditSelectMoreChoiceState extends State<EditSelectMoreChoice> {
  String brand = tSelectBrandCar;
  String model = tSelectModelCar;
  String yearModel = '';
  String fuelType = tSelectFeulTypeCar;

  String? valueBrand;
  String? valueModel;
  String? valueYear;
  String? valueFuelType;

  List<String> carBrands = ['sdfa', 'asdfasd', 'asdf'];
  List<String> carBrandsT = [];
  List<String> carModels = ['asdf', 'asdf', 'asdfasdf'];
  List<String> carModelsT = [];
  List<CarBrandModel> carDetail = [];

  TextEditingController _controller = TextEditingController();

  FocusNode myFocusNode = new FocusNode();

  void setStateBrand(Object? item) {
   setState(() {
      valueBrand = item.toString();
      widget.car.carOld.brand = item.toString();
      for (var i = 0; i < carDetail.length; i++) {
        if (carDetail[i].brand == valueBrand) {
          carModelsT = carDetail[i].model;
        }
      }
      carModels = carModelsT;
      logger.d(carModels);
    });
  }

  void setStateModel(Object? item) {
    setState(() {
      valueModel = item.toString();
      widget.car.carOld.model = item.toString();
    });
  }

  void setStateYear(Object? item) {
    setState(() {
      valueYear = item.toString();
      widget.car.carOld.year = item.toString();
    });
  }

  void setStateFuelType(Object? item) {
    setState(() {
      valueFuelType = item.toString();
      widget.car.carOld.fuelType = item.toString();
    });
  }

  void setStateRegisNumber(Object? item) {
    setState(() {
      valueFuelType = item.toString();
      widget.car.carOld.regisNumber = item.toString();
    });
  }

  @override
  void initState() {
    for (var i = 0; i < carMockup.length; i++) {
      if (carMockup[i].carType == widget.car.carOld.type) {
        logger.d(carMockup[i].carType);
        logger.d(widget.car.carOld.type);
        carDetail = carMockup[i].datail;
        for (var j = 0; j < carDetail.length; j++) {
          carBrandsT.add(carDetail[j].brand);
        }
      }
      carBrands = carBrandsT;
      logger.d(carBrands);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: textColorBlack),
        backgroundColor: primaryColor,
        title: Text(
          tEditCar + 'คันที่: ' + widget.car.index.toString(),
          style: TextStyle(color: textColorBlack),
        ),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(defualtPaddingMedium),
                child: ShowInfoCarCard(
                  car: widget.car.carOld,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _fromTextRegisNumber(),
              SizedBox(
                height: 10,
              ),
              _selectDropdownBrand(tBrand, carBrands),
              valueBrand == null
                  ? Text('')
                  : _selectDropdownModel(tModel, carModels),
              valueModel == null
                  ? Text('')
                  : _selectDropdownYear(tYearModel, yearModelCar),
              valueYear == null
                  ? Text('')
                  : _selectDropdownFuelType(tFuelType, fuelTypeCar),
              SizedBox(
                height: 20,
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
            if (widget.car.carOld.brand == brand ||
                widget.car.carOld.model == model ||
                widget.car.carOld.year == yearModel ||
                widget.car.carOld.fuelType == fuelType ||
                widget.car.carOld.regisNumber == '') {
              return _showDialog(context);
            } else {
              navigatorToShowInfoEditCar();
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

  void navigatorToShowInfoEditCar() {
    Navigator.pushNamed(context, EDITCAR_SHOWINFO_ROUTE, arguments: widget.car);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertPleaseInputInfo();
      },
    );
  }

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
            width: 245,
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
            width: 245,
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
            width: 245,
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
            width: 220,
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

  Widget _fromTextRegisNumber() {
    return Padding(
      padding: const EdgeInsets.only(
          right: defualtPaddingHight + 10, left: defualtPaddingHight + 10),
      child: TextField(
        onChanged: (String value) {
          setState(() {
            widget.car.carOld.regisNumber = value;
            logger.d(widget.car.carOld.regisNumber);
          });
        },
        controller: _controller,
        focusNode: myFocusNode,
        cursorColor: textColorBlack,
        //style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
            hoverColor: primaryColor,
            hintText: widget.car.carOld.regisNumber,
            labelText: 'ป้ายทะเบียน',
            labelStyle: TextStyle(
                color: myFocusNode.hasFocus ? textColorBlack : Colors.black,
                fontSize: fontSizeM)),
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
