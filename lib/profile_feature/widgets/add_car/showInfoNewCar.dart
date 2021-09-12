import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';

import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class ShowInfoNewCar extends StatefulWidget {
  ShowInfoNewCar({Key? key}) : super(key: key);

  @override
  _ShowInfoNewCarState createState() => _ShowInfoNewCarState();
}

class _ShowInfoNewCarState extends State<ShowInfoNewCar> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
