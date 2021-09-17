import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class SelectServiceOfGarage extends StatefulWidget {
  List<Service> services;
  SelectServiceOfGarage({Key? key, required this.services}) : super(key: key);

  @override
  _SelectServiceOfGarageState createState() => _SelectServiceOfGarageState();
}

class _SelectServiceOfGarageState extends State<SelectServiceOfGarage> {
  Map<String, bool> List = {
    'ยาง': false,
    'แบตเตอรี่': false,
    'ทุกเซอร์วิส': false,
    'เติมน้ำมัน': false,
    'เครื่องยนต์': false,
    'รถลาก': false,
    // 'รถยก': false,
  };

  var holder_1 = [];

  getItems() {
    List.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: defualtPaddingHight,
        right: defualtPaddingHight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: defualtPaddingLow),
            child: Text(
              tServiceOfGarageThai,
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: List.keys.map((String key) {
              return Container(
                height: 35,
                child: new CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: new Text(key),
                  value: List[key],
                  activeColor: hexToColor(primaryCodeColor),
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      List[key] = value!;
                    });
                  },
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            obscureText: true,
            style: TextStyle(fontSize: 12),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              helperText: 'เช่น ยางรั่ว, ยางระเบิด, เบรคไม่อยู่, สตาร์ทไม่ติด',
              helperStyle: TextStyle(fontSize: 10),
              hintText:
                  'รายละเอียดเพิ่มเติม(ไม่จำเป็น) เช่น ยางรั่ว, ยางระเบิด, เบรคไม่อยู่, สตาร์ทไม่ติด',
              labelText: 'รายละเอียดเพิ่มเติม',
            ),
          )
        ],
      ),
    );
  }
}
