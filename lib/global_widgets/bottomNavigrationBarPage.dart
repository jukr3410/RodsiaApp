import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/core/repository/service_type_repository.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/service_type_bloc.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/homePage.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/filterGarage.dart';
import 'package:rodsiaapp/find_problem_feature/widgets/findProblemPage.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
import 'package:rodsiaapp/global_widgets/menusSetting.dart';
import 'package:rodsiaapp/notify_feature/widgets/notifyPage.dart';
import 'package:rodsiaapp/profile_feature/widgets/ProfilePage.dart';

class BottomNavigrationBar extends StatefulWidget {
  final User user;
  const BottomNavigrationBar({Key? key, required this.user}) : super(key: key);

  @override
  _BottomNavigrationBarState createState() => _BottomNavigrationBarState();
}

class _BottomNavigrationBarState extends State<BottomNavigrationBar> {
  int _selectedIndex = 0;

  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(tImageAsset('home-navbar'))),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(right: 50),
          child: ImageIcon(AssetImage(tImageAsset("findProblem-navbar"))),
        ),
        label: 'Find-problem'),
    BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(left: 50),
          child: ImageIcon(AssetImage(tImageAsset('notify-navbar'))),
        ),
        label: 'Notify'),
    BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(tImageAsset('more-navbar'))),
      label: 'More',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pageWidget = <Widget>[
      HomePage(),
      FindProblemPage(),
      NotifyPage(),
      MenusSetting(
        user: widget.user,
      )
    ];
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          height: 60,
          width: 60,
          child: BlocProvider(
              create: (context) => ServiceTypeBloc(
                  serviceTypeRepository: ServiceTypeRepository()),
              child: FilterGarage())),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          items: _menuBar,
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey.shade700,
          onTap: _onItemTapped,
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          unselectedIconTheme: IconThemeData(size: 24),
          backgroundColor: hexToColor(primaryCodeColor),
        ),
      ),
    );
  }
}
