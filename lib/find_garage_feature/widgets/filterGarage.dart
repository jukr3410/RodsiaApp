import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class FilterGarage extends StatefulWidget {
  FilterGarage({Key? key}) : super(key: key);

  @override
  _FilterGarageState createState() => _FilterGarageState();
}

class _FilterGarageState extends State<FilterGarage> {
  Map<String, bool> List = {
    'ยาง': false,
    'แบตเตอรี่': false,
    'ทุกเซอร์วิส': false,
    'เติมน้ำมัน': false,
    'เครื่องยนต์': false,
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
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0))),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 6,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: hexToColor(codeColorBlack),
                                  borderRadius: borderRadiusLow),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                height: 25,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'ปัญหาที่เกิดขึ้น',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            ListView(
                              shrinkWrap: true,
                              children: List.keys.map((String key) {
                                return Container(
                                  height: 40,
                                  child: new CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
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
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 20, right: 20, top: 40),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                child: Material(
                                  borderRadius: borderRadiusMedium,
                                  color: hexToColor(primaryCodeColor),
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(tSearch,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: hexToColor(codeColorBlack),
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                );
              });
            });
      },
      child: Container(
        // padding: EdgeInsets.all(15.0),
        child: ImageIcon(AssetImage(tImageAsset('findGarage-navbar')),
            color: Colors.black, size: 45),
      ),
      elevation: 4.0,
      backgroundColor: Colors.grey.shade200,
    );
  }
}
