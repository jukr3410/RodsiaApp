import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/main.dart';

class FilterGarage extends StatefulWidget {
  FilterGarage({Key? key}) : super(key: key);
  @override
  _FilterGarageState createState() => _FilterGarageState();
}

class _FilterGarageState extends State<FilterGarage>
    with SingleTickerProviderStateMixin {
  String selectProblem = '';
  String selectVehicleType = '';
  int numSelect = 0;
  TextStyle styleTitleInfo = TextStyle(fontSize: fontSizeL);
  List<Widget> selectToFilter = <Widget>[];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 6,
                        width: 50,
                        decoration: BoxDecoration(
                            color: hexToColor(codeColorBlack),
                            borderRadius: borderRadiusLow),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20, left: 20),
                              height: 45,
                              decoration: BoxDecoration(
                                  color: textColorBlack,
                                  borderRadius: borderRadiusHight,
                                  boxShadow: [boxShadow]),
                              child: TabBar(
                                controller: _tabController,
                                // give the indicator a decoration (color and border radius)
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    25.0,
                                  ),
                                  color: primaryColor,
                                ),
                                labelColor: textColorBlack,
                                labelStyle: TextStyle(
                                    fontSize: 15, fontFamily: 'Kanit'),
                                unselectedLabelColor:
                                    hexToColor(primaryCodeColor),
                                tabs: [
                                  // first tab [you can add an icon using the icon property]
                                  Tab(
                                    text: 'ปัญหาที่เกิดขึ้น',
                                  ),
                                  // second tab [you can add an icon using the icon property]
                                  Tab(
                                    text: tSelectVehicleTypeCar,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // first tab bar view widget
                            Center(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                // selectToFilter[numSelect],
                                GridView.count(
                                  childAspectRatio: (3 / 2.1),
                                  crossAxisCount: 3,
                                  padding: EdgeInsets.all(20),
                                  shrinkWrap: true,
                                  children: List.generate(
                                      serviceTypeName.length, (index) {
                                    return Column(
                                      children: [
                                        FlatButton(
                                          color: selectProblem ==
                                                  serviceTypeName[index]
                                              ? primaryColor
                                              : Colors.transparent,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      defualtPaddingLow)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  tImageAsset(
                                                      serviceTypeName[index]
                                                          .toString()),
                                                  width: 40,
                                                ),
                                                Container(
                                                  width: 50,
                                                  child: Text(
                                                    serviceTypeName[index]
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              selectProblem =
                                                  serviceTypeName[index]
                                                      .toString();
                                              print(selectProblem);
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                                ),

                                buttonSelect()
                              ],
                            )),
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GridView.count(
                                    childAspectRatio: (2 / 0.9),
                                    crossAxisCount: 2,
                                    shrinkWrap: true,
                                    children: List.generate(vehicleType.length,
                                        (index) {
                                      return Column(
                                        children: [
                                          FlatButton(
                                            color: selectVehicleType ==
                                                    vehicleType[index]
                                                ? primaryColor
                                                : Colors.transparent,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        defualtPaddingLow)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    tImageAsset(
                                                        vehicleType[index]
                                                            .toString()),
                                                    width: 50,
                                                  ),
                                                  Text(vehicleType[index]
                                                      .toString())
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                selectVehicleType =
                                                    vehicleType[index]
                                                        .toString();
                                                print(selectVehicleType);
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  buttonSelect(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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

  void navigatorToListGarage() {
    Navigator.pushNamed(context, MAIN_ROUTE,
        arguments: FilterGarageModel(
            serviceType: selectProblem, carType: selectVehicleType));
  }

  void navigatorToListGarageAll() {
    Navigator.pushNamed(context, MAIN_ROUTE,
        arguments: FilterGarageModel(serviceType: '', carType: ''));
  }

  Widget buttonSelect() {
    if (selectProblem == '' || selectVehicleType == '') {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            Container(
              height: buttonHeightSmall,
              width: double.infinity,
              child: Material(
                borderRadius: borderRadiusMedium,
                color: textColorBlack,
                child: MaterialButton(
                  onPressed: () {},
                  child: Text('กรุณาเลือกให้ครบ!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 15,
                      )),
                ),
              ),
            ),
            GFButton(
              onPressed: () {
                navigatorToListGarageAll();
              },
              child: Text('ค้นหาทั้งหมด'),
              color: textColorBlack,
              type: GFButtonType.transparent,
            )
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          Container(
            height: buttonHeightSmall,
            width: double.infinity,
            child: Material(
              borderRadius: borderRadiusMedium,
              color: hexToColor(primaryCodeColor),
              child: MaterialButton(
                onPressed: () {
                  navigatorToListGarage();
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
          GFButton(
            onPressed: () {
              navigatorToListGarageAll();
            },
            child: Text('ค้นหาทั้งหมด'),
            color: textColorBlack,
            type: GFButtonType.transparent,
          )
        ],
      ),
    );
  }
}
