import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/services_type_model.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/service_type_bloc.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/main.dart';
import 'package:shimmer/shimmer.dart';

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
  late ServiceTypeBloc _serviceTypeBloc;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _serviceTypeBloc = BlocProvider.of<ServiceTypeBloc>(context);
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
                  child: BlocConsumer<ServiceTypeBloc, ServiceTypeState>(
                      listener: (context, serviceTypeState) {},
                      builder: (context, serviceTypeState) {
                        if (serviceTypeState is ServiceTypeInitialState ||
                            serviceTypeState is ServiceTypeLoadingState) {
                          return Center(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16),
                            child: _shimmer(),
                          ));
                        } else if (serviceTypeState
                            is ServiceTypeSuccessState) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        } else if (serviceTypeState is ServiceTypeErrorState) {
                          return Center(
                              child: Text(
                            serviceTypeState.error,
                            textAlign: TextAlign.center,
                          ));
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 6,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: hexToColor(codeColorBlack),
                                  borderRadius: borderRadiusLow),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10, right: 20, left: 20),
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
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // first tab bar view widget
                                  Center(
                                      child: Column(
                                    children: <Widget>[
                                      // selectToFilter[numSelect],

                                      GridView.count(
                                        childAspectRatio: (3 / 2.5),
                                        crossAxisCount: 3,
                                        padding: EdgeInsets.all(20),
                                        shrinkWrap: true,
                                        children: List.generate(
                                            serviceType.length, (index) {
                                          return FlatButton(
                                            color: selectProblem ==
                                                    serviceType[index]
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
                                                        serviceType[index]
                                                            .toString()),
                                                    width: 45,
                                                  ),
                                                  Text(serviceTypeName[index]
                                                      .toString())
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                selectProblem =
                                                    serviceType[index]
                                                        .toString();

                                                print(selectProblem);
                                              });
                                            },
                                          );
                                        }),
                                      ),

                                      buttonSelect()
                                    ],
                                  )),
                                  Center(
                                    child: Column(
                                      children: [
                                        GridView.count(
                                          childAspectRatio: (2 / 1.2),
                                          crossAxisCount: 2,
                                          shrinkWrap: true,
                                          children: List.generate(
                                              vehicleType.length, (index) {
                                            return FlatButton(
                                              color: selectVehicleType ==
                                                      vehicleType[index]
                                                  ? primaryColor
                                                  : Colors.transparent,
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          defualtPaddingLow)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      tImageAsset(
                                                          vehicleType[index]
                                                              .toString()),
                                                      width: 60,
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
                                            );
                                          }),
                                        ),
                                        buttonSelect()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                );
              }
              );
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

  Widget buttonSelect() {
    if (selectProblem == '' || selectVehicleType == '') {
      return Padding(
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
      );
    }
    return Padding(
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
    );
  }

  _shimmer() {
    return Shimmer.fromColors(
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 6,
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100);
  }
}
