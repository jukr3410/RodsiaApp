import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/main.dart';

class buttonToEditProfile extends StatefulWidget {
  User user;
  buttonToEditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _buttonToEditProfileState createState() => _buttonToEditProfileState();
}

class _buttonToEditProfileState extends State<buttonToEditProfile> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          navigatorToEditProfile();
        },
        child: Text(
          tEdit,
          style: TextStyle(fontSize: fontSizeL, color: Colors.white),
        ));
  }

  void navigatorToEditProfile() {
    Navigator.pushNamed(context, EDITPROFILE_ROUTE, arguments: widget.user);
  }
}
