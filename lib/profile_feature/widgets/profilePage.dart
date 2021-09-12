import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/profile_feature/widgets/infoCarCard.dart';
import 'package:rodsiaapp/profile_feature/widgets/infoProfile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.yellow.shade800,
            Colors.yellow.shade400,
            Colors.yellow.shade50
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            InfoProfile(),
            SizedBox(
              height: 50,
            ),
            InfoCarCard(),
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: textColorBlack),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  color: primaryColor,
                )),
            SizedBox(
              height: 5,
            ),
            Text(tAddCar)
          ],
        ),
      ),
    );
  }
}
