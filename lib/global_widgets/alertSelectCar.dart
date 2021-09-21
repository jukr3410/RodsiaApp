import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:direct_select/direct_select.dart';
import 'package:rodsiaapp/core/models/car_model.dart';

class AlertSelectCar extends StatefulWidget {
  AlertSelectCar({
    Key? key,
  }) : super(key: key);

  @override
  _AlertSelectCarState createState() => _AlertSelectCarState();
}

class _AlertSelectCarState extends State<AlertSelectCar> {
  int selectedIndex = 0;

  Car car = Car(id: "", brand: "", model: "", type: "", year: "", fuelType: "");
  List<Widget> _buildItems() {
    return mockUpCar
        .map((val) => SelectionItem(
              car: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidthLarge,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tSelectCarForRequest,
                style: TextStyle(
                    fontSize: fontSizeL,
                    color: textColorBlack,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Kanit'),
              ),
              SizedBox(
                height: defualtPaddingMedium,
              ),
              DirectSelect(
                  itemExtent: 40.0,
                  backgroundColor: bgColor,
                  selectedIndex: selectedIndex,
                  mode: DirectSelectMode.drag,
                  child: SelectionItem(
                    isForList: false,
                    car: mockUpCar[selectedIndex],
                  ),
                  onSelectedItemChanged: (int? index) {
                    setState(() {
                      selectedIndex = index!;
                      car = mockUpCar[selectedIndex];
                      print(car.toJson());
                    });
                  },
                  items: _buildItems()),
              SizedBox(
                height: defualtPaddingMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: buttonHeightSmall,
                      width: buttonWidthSmall,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Ok');
                        },
                        child: Text(tOKThai),
                        style: flatButtonStyle(primaryColor, textColorBlack),
                      )),
                  GFButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancal');
                    },
                    child: Text(tCancleThai),
                    textColor: textColorBlack,
                    type: GFButtonType.transparent,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectionItem extends StatelessWidget {
  final Car car;
  final bool isForList;

  const SelectionItem({Key? key, required this.car, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              color: primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    TextStyle _textStyle = TextStyle(fontSize: 15, fontFamily: 'Kanit');
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(car.brand, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text(car.model, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text(car.year, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text('(${car.fuelType})', style: _textStyle)
        ],
      ),
    );
  }
}
