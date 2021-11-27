import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
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
    return Container(
      decoration: BoxDecoration(
          boxShadow: [boxShadow],
          borderRadius: borderRadiusMedium,
          color: bgColor),
      child: Padding(
        padding: const EdgeInsets.all(defualtPaddingLow),
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Column(
                children: [
                  ClipOval(
                      child:
                          _proFileImage(widget.user.profileImage.toString())),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    widget.user.name,
                    style: TextStyle(
                        fontSize: fontSizeXl, fontWeight: FontWeight.w600),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Row(
                  children: [
                    Text(tPhone + ': '),
                    Text(
                      widget.user.phone,
                    )
                  ],
                ),
                Container(
                  width: 150,
                  child: Row(
                    children: [
                      Text(tEmail + ': '),
                      Text(
                        widget.user.email,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _proFileImage(String profileImage) {
    if (profileImage == '') {
      return Image.asset(
        tImageAsset('profile'),
        width: 100,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: profileImage,
        placeholder: (context, url) => CircularProgressIndicator(
          color: textColorBlack,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        height: 100,
        width: 100,
      );
    }
  }
}
