import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/homePage.dart';
import 'package:rodsiaapp/global_widgets/filterGarage.dart';
import 'package:rodsiaapp/global_widgets/findProblemPage.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/global_widgets/notifyPage.dart';
import 'package:rodsiaapp/global_widgets/profilePage.dart';

class BottomNavigrationBar extends StatefulWidget {
  BottomNavigrationBar({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  _BottomNavigrationBarState createState() => _BottomNavigrationBarState();
}

class _BottomNavigrationBarState extends State<BottomNavigrationBar> {
  int _selectedIndex = 0;
  List<Widget> _pageWidget = <Widget>[
    HomePage(),
    FindProblemPage(),
    FilterGarage(),
    NotifyPage(),
    ProfilePage(),
  ];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("image/icon-home-navbar.png")),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(right: 50),
          child: ImageIcon(AssetImage("image/icon-findProblem-navbar.png")),
        ),
        label: 'Find-problem'),
    BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(left: 50),
          child: ImageIcon(AssetImage("image/icon-notify-navbar.png")),
        ),
        label: 'Notify'),
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("image/icon-profile-navbar.png")),
        label: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          // padding: EdgeInsets.all(15.0),
          child: ImageIcon(AssetImage("image/icon-findGarage-navbar.png"),
              color: Colors.black, size: 40),
        ),
        elevation: 4.0,
        backgroundColor: Colors.grey.shade200,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        // selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey.shade500,
        onTap: _onItemTapped,
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        // selectedIconTheme: IconThemeData(size: 26),
        selectedFontSize: 13,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedIconTheme: IconThemeData(size: 24),
        backgroundColor: hexToColor(primaryCodeColor),
      ),
    );
  }
}
