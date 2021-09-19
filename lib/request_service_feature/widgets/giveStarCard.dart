import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';

class GiveStarCard extends StatefulWidget {
  GiveStarCard({Key? key}) : super(key: key);

  @override
  _GiveStarCardState createState() => _GiveStarCardState();
}

class _GiveStarCardState extends State<GiveStarCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 70,
          child: ClipOval(
            child: Image.asset(
              tImageAsset('profile'),
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
