import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        onPressed: () {},
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: ImageIcon(AssetImage("image/findGarage.png")),
        ),
        elevation: 4.0,
        backgroundColor: Colors.grey.shade200,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
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
                  AssetImage("image/icon-findGarage-navbar.png"),
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
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => Otp()));
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
        color: Color(0xFECE2F),
      ),
      // items: const <BottomNavigationBarItem>[
      //   BottomNavigationBarItem(
      //     icon: ImageIcon(AssetImage("image/icon-home-navbar.png")),
      //     label: 'Home',
      //   ),
      //   BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage("image/icon-findProblem-navbar.png")),
      //       label: 'Find-problem'),
      //   BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage("image/logo.png")),
      //       label: 'Find-Garage'),
      //   BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage("image/icon-notify-navbar.png")),
      //       label: 'Notify'),
      //   BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage("image/icon-profile-navbar.png")),
      //       label: 'Profile'),
      // ],
      // currentIndex: _selectedIndex,
      // fixedColor: Colors.black,
      // type: BottomNavigationBarType.fixed,
      // selectedIconTheme: IconThemeData(size: 30),
      // showUnselectedLabels: false,
      // showSelectedLabels: false,
      // unselectedIconTheme: IconThemeData(size: 24),
      // onTap: _onItemTapped,
      // backgroundColor: hexToColor("#FECE2F"),
      // ),
    );
  }
}
