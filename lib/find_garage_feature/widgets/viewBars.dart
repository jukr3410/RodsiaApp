import 'package:flutter/material.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/garage_list.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/constants.dart';

class ViewBars extends StatefulWidget {
  ViewBars({Key? key}) : super(key: key);

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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 14, top: 10, right: 40, left: 40),
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
                    AssetImage('image/icon-mapView.png'),
                    color: Colors.black,
                    size: 19,
                  ),
                  text: 'Map view',
                  iconMargin: EdgeInsets.only(bottom: 2, top: 5),
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  icon: ImageIcon(
                    AssetImage('image/icon-listView.png'),
                    color: Colors.black,
                    size: 19,
                  ),
                  text: 'List View',
                  iconMargin: EdgeInsets.only(bottom: 2, top: 5),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // first tab bar view widget
                Center(
                  child: Text(
                    'Map view',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

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
                  child: new GarageList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
