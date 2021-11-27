import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';

import 'package:rodsiaapp/request_service_feature/widgets/carouselImageReqService.dart';

class InfoGarageFormSelect extends StatefulWidget {
  Garage garage;
  InfoGarageFormSelect({Key? key, required this.garage}) : super(key: key);

  @override
  _InfoGarageFormSelectState createState() => _InfoGarageFormSelectState();
}

class _InfoGarageFormSelectState extends State<InfoGarageFormSelect> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselImageReqService(images: widget.garage.images),
        Container(
          height: 90,
          margin: EdgeInsets.only(
            top: 170,
            left: defualtPaddingHight,
            right: defualtPaddingHight,
          ),
          decoration: BoxDecoration(
              borderRadius: borderRadiusMedium,
              boxShadow: [boxShadow],
              color: bgColor),
          child: Padding(
            padding: const EdgeInsets.all(defualtPaddingLow),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 35,
                  child: ClipOval(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.garage.logoImage,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: textColorBlack,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                        height: 65,
                        width: 65,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 190,
                      child: Text(
                        widget.garage.name,
                        style: TextStyle(
                            fontSize: fontSizeL, fontWeight: FontWeight.w600),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Text(tPhone + ': '),
                        Text(
                          widget.garage.phone,
                        )
                      ],
                    ),
                    Container(
                      width: 190,
                      child: Row(
                        children: [
                          Text(tEmail + ': '),
                          Text(
                            widget.garage.email.toString(),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
