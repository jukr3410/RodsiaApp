import 'package:flutter/material.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageList.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garageListDisplay.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/mapView.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/searchGaragePage.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/constants.dart';

import 'mapViewDisplay.dart';

class ViewBars extends StatefulWidget {
  final FilterGarageModel filter;
  ViewBars({Key? key, required this.filter}) : super(key: key);

  @override
  _ViewBarsState createState() => _ViewBarsState();
}

class _ViewBarsState extends State<ViewBars>
    with SingleTickerProviderStateMixin {
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: 14, top: 10, right: 0, left: 40),
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadiusHight,
                        boxShadow: [boxShadow]),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: hexToColor(primaryCodeColor),
                      ),
                      labelColor: Colors.white,
                      labelStyle: TextStyle(fontSize: 15),
                      unselectedLabelColor: hexToColor(primaryCodeColor),
                      tabs: [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          icon: ImageIcon(
                            AssetImage(tImageAsset('mapView')),
                            color: Colors.black,
                            size: 19,
                          ),
                          text: 'Map view',
                          iconMargin: EdgeInsets.only(bottom: 2, top: 5),
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                          icon: ImageIcon(
                            AssetImage(tImageAsset('listView')),
                            color: Colors.black,
                            size: 19,
                          ),
                          text: 'List View',
                          iconMargin: EdgeInsets.only(bottom: 2, top: 5),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                    icon: ImageIcon(AssetImage(tImageAsset('search'))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SearchPage();
                      }));
                    })
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Center(
                      child: DisplayMapView(
                    filter: widget.filter,
                  )),

                  // second tab bar view widget
                  // Center(
                  //   child: Text(
                  //     'List view',
                  //     style: TextStyle(
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),

                  Center(
                    child: DisplayGarageList(
                      filter: widget.filter,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
