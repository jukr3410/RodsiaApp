import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/user_model.dart';

class InfoProfile extends StatefulWidget {
  final User user;
  InfoProfile({Key? key, required this.user}) : super(key: key);

  @override
  _InfoProfileState createState() => _InfoProfileState();
}

class _InfoProfileState extends State<InfoProfile> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: defualtPaddingMedium,
        right: defualtPaddingMedium,
      ),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
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
                    // Positioned(
                    //     bottom: 7,
                    //     right: 18,
                    //     child: Container(
                    //       height: 35,
                    //       width: 35,
                    //       child: IconButton(
                    //         icon: Icon(
                    //           Icons.add_a_photo,
                    //           size: 18,
                    //           color: Colors.white,
                    //         ),
                    //         onPressed: () {},
                    //       ),
                    //       decoration: BoxDecoration(
                    //           color: textColorBlack,
                    //           borderRadius: borderRadiusHight),
                    //     )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.name,
                style: TextStyle(
                    fontSize: fontSizeXl, fontWeight: FontWeight.w600),
                softWrap: true,
                maxLines: 1,
              ),
              Row(
                children: [
                  Text(tPhone + ': '),
                  Text(
                    widget.user.phone,
                  )
                ],
              ),
              Row(
                children: [
                  Text(tEmail + ': '),
                  Text(
                    widget.user.email,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
