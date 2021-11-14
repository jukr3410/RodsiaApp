import 'package:cached_network_image/cached_network_image.dart';
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
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.user.profileImage!,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: textColorBlack,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
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
