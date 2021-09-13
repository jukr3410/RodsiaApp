import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';

class SelectVehicleTypeCard extends StatefulWidget {
  SelectVehicleTypeCard({Key? key}) : super(key: key);

  @override
  _SelectVehicleTypeCardState createState() => _SelectVehicleTypeCardState();
}

class _SelectVehicleTypeCardState extends State<SelectVehicleTypeCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tSelectVehicleTypeCar,
            style: TextStyle(
              fontSize: fontSizeXl,
              color: textColorBlack,
            ),
          ),
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
      children: List.generate(4, (index) {
        final _item = vehicleType[index];
        return _listItemTypeCar(_item.toString());
      }),
    );
  }

  Widget _listItemTypeCar(String typeCar) {
    return Column(
      children: [
        FlatButton(
          child: Column(
            children: [
              Image.asset(
                tImageAsset(typeCar),
                width: 80,
              ),
              Text(typeCar)
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
