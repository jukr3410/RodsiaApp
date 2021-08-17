import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';

class NavigrationBar extends StatefulWidget {
  @override
  _NavigrationBarState createState() => _NavigrationBarState();
}

class _NavigrationBarState extends State<NavigrationBar> {
  int _selectedIndex = 0;

  void updateTabSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // bottomNavigationBar: BottomNavigationBar(
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          updateTabSelection(4);
        },
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: ImageIcon(AssetImage("image/icon-findGarage-navbar.png"),
              color: _selectedIndex == 4 ? primaryColor : Colors.black),
        ),
        elevation: 4.0,
        backgroundColor: Colors.grey.shade200,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: defualtPadding, right: defualtPadding),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                //update the bottom app bar view each time an item is clicked
                onPressed: () {
                  updateTabSelection(0);
                },
                iconSize: 27.0,
                icon: ImageIcon(
                  AssetImage("image/icon-home-navbar.png"),
                  //darken the icon if it is selected or else give it a different color
                  color: _selectedIndex == 0 ? Colors.black : Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(1);
                },
                iconSize: 27.0,
                icon: ImageIcon(
                  AssetImage("image/icon-findProblem-navbar.png"),
                  color: _selectedIndex == 1 ? Colors.black : Colors.white,
                ),
              ),
              //to leave space in between the bottom app bar items and below the FAB
              SizedBox(
                width: 50.0,
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(2);
                },
                iconSize: 27.0,
                icon: ImageIcon(
                  AssetImage("image/icon-notify-navbar.png"),
                  color: _selectedIndex == 2 ? Colors.black : Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(3);
                },
                iconSize: 27.0,
                icon: ImageIcon(
                  AssetImage("image/icon-profile-navbar.png"),
                  color: _selectedIndex == 3 ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
        ),
        //to add a space between the FAB and BottomAppBar
        shape: CircularNotchedRectangle(),
        //color of the BottomAppBar
        color: hexToColor("#FECE2F"),
      ),
    );
  }
}
