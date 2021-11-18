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
                        child:
                            _proFileImage(widget.user.profileImage.toString())),
                    _addOrChangeProfileImage(
                        widget.user.profileImage.toString()),
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

  _addOrChangeProfileImage(String profileImage) {
    if (profileImage == '') {
      return Positioned(
          bottom: 0,
          right: 15,
          child: Container(
            height: 35,
            width: 35,
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: 18,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            decoration: BoxDecoration(
                color: textColorBlack, borderRadius: borderRadiusHight),
          ));
    } else {
      return GFButton(
        onPressed: () {},
        type: GFButtonType.transparent,
        textStyle: TextStyle(color: textColorBlack, fontSize: fontSizeS),
        child: Text('เปลี่ยนรูปภาพ'),
      );
    }
  }

  _proFileImage(String profileImage) {
    if (profileImage == '') {
      return Image.asset(
        tImageAsset('profile'),
        width: 120,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: profileImage,
        placeholder: (context, url) => CircularProgressIndicator(
          color: textColorBlack,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        height: 120,
        width: 120,
      );
    }
  }
}
