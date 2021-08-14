import 'package:flutter/material.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/global_widgets/navigrationBar.dart';
import 'package:rodsiaapp/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeHome = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 14, top: 10, right: 44, left: 44),
            height: 55,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 4,
                    offset: Offset(2, 4),
                  )
                ]),
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
          ImageIcon(
            AssetImage('image/icon-search.png'),
            size: 23,
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
                Center(
                  child: Text(
                    'List view',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
