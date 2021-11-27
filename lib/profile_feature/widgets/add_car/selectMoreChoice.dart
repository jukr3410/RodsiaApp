import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:rodsiaapp/car_mockup.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/global_widgets/alertPleaseInputInfo.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/widgets/showInfoCarCard.dart';

class SelectMoreChoice extends StatefulWidget {
  Car car;
  SelectMoreChoice({Key? key, required this.car}) : super(key: key);

  @override
  _SelectMoreChoiceState createState() => _SelectMoreChoiceState();
}

class _SelectMoreChoiceState extends State<SelectMoreChoice> {
  String? valueBrand;
  String? valueModel;
  String? valueYear;
  String? valueFuelType;
  TextEditingController _controller = TextEditingController();

  List<String> carBrands = ['sdfa', 'asdfasd', 'asdf'];
  List<String> carBrandsT = [];
  List<String> carModels = ['asdf', 'asdf', 'asdfasdf'];
  List<String> carModelsT = [];
  List<CarBrandModel> carDetail = [];

  FocusNode myFocusNode = new FocusNode();

  void setStateBrand(Object? item) {
    setState(() {
      valueBrand = item.toString();
      widget.car.brand = item.toString();
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
  void initState() {
    for (var i = 0; i < carMockup.length; i++) {
      if (carMockup[i].carType == widget.car.type) {
        logger.d(carMockup[i].carType);
        logger.d(widget.car.type);
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
          tAddCar,
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
                  car: widget.car,
                ),
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
            if (widget.car.brand == tSelectBrandCar ||
                widget.car.model == tSelectModelCar ||
                widget.car.year == '' ||
                widget.car.fuelType == tSelectFeulTypeCar ||
                widget.car.regisNumber == '') {
              return _showDialog(context);
            } else {
              navigatorToSelectMoreChoice();
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

  void navigatorToSelectMoreChoice() {
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

// select dropdown
  Widget _selectDropdownBrand(String titleInfoText, List<String> list) {
    return SingleChildScrollView(
      child: Padding(
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
                  items: list
                      .map((String item) => DropdownMenuItem<String>(
                          child: Text(item), value: item))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectDropdownModel(String titleInfoText, List<String> list) {
    return SingleChildScrollView(
      child: Padding(
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
      ),
    );
  }

  Widget _selectDropdownYear(String titleInfoText, List<String> list) {
    return SingleChildScrollView(
      child: Padding(
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
      ),
    );
  }

  Widget _selectDropdownFuelType(String titleInfoText, List<String> list) {
    return SingleChildScrollView(
      child: Padding(
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
            widget.car.regisNumber = value;
            logger.d(widget.car.regisNumber);
          });
        },
        controller: _controller,
        focusNode: myFocusNode,
        cursorColor: textColorBlack,
        //style: Theme.of(context).textTheme.headline5,
        decoration: InputDecoration(
            hoverColor: primaryColor,
            hintText: 'ตัวอย่าง ฆก1565',
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
