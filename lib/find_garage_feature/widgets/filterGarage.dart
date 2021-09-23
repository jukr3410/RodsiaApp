import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class FilterGarage extends StatefulWidget {
  FilterGarage({Key? key}) : super(key: key);

  @override
  _FilterGarageState createState() => _FilterGarageState();
}

class _FilterGarageState extends State<FilterGarage> {
  // Map<String, bool> List = {
  //   'ยาง': false,
  //   'แบตเตอรี่': false,
  //   'ทุกเซอร์วิส': false,
  //   'เติมน้ำมัน': false,
  //   'เครื่องยนต์': false,
  //   // 'รถยก': false,
  // };

  // var holder_1 = [];

  // getItems() {
  //   serviceType.forEach((key, value) {
  //     if (value == true) {
  //       holder_1.add(key);
  //     }
  //   });

  //   print(holder_1);

  //   holder_1.clear();
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   _selectServiceType();
  // }

  String selectProblem = '';

  TextStyle styleTitleInfo = TextStyle(fontSize: fontSizeL);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
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
                        Container(
                          height: 25,
                          child: Text(
                            'ปัญหาที่เกิดขึ้น',
                            style: TextStyle(
                                fontSize: fontSizeXl,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                          childAspectRatio: (3 / 2.5),
                          crossAxisCount: 3,
                          padding: EdgeInsets.all(20),
                          shrinkWrap: true,
                          children: List.generate(serviceType.length, (index) {
                            return Column(
                              children: [
                                FlatButton(
                                  color: selectProblem == serviceType[index]
                                      ? primaryColor
                                      : Colors.transparent,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(
                                          defualtPaddingLow)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          tImageAsset(
                                              serviceType[index].toString()),
                                          width: 50,
                                        ),
                                        Text(serviceTypeName[index].toString())
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectProblem =
                                          serviceType[index].toString();

                                      print(selectProblem);
                                    });
                                  },
                                ),
                              ],
                            );
                          }),
                        ),
                        // ListView(
                        //   shrinkWrap: true,
                        //   children: List.keys.map((String key) {
                        //     return Container(
                        //       height: 40,
                        //       child: new CheckboxListTile(
                        //         controlAffinity:
                        //             ListTileControlAffinity.leading,
                        //         title: new Text(key),
                        //         value: List[key],
                        //         activeColor: hexToColor(primaryCodeColor),
                        //         checkColor: Colors.white,
                        //         onChanged: (bool? value) {
                        //           setState(() {
                        //             List[key] = value!;
                        //           });
                        //         },
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),

                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Container(
                            height: buttonHeightSmall,
                            width: double.infinity,
                            child: Material(
                              borderRadius: borderRadiusMedium,
                              color: hexToColor(primaryCodeColor),
                              child: MaterialButton(
                                onPressed: () {
                                  navigatorToSelectServiceType();
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
                    ));
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

  void navigatorToSelectServiceType() {
    Navigator.pop(context);
  }
}
