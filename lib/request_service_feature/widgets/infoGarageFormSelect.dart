import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/global_widgets/carouselImage.dart';
import 'package:rodsiaapp/global_widgets/hexTocolor.dart';
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
        CarouselImageReqService(),
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
                    child: Image.asset(
                      tImageAsset('profile'),
                      height: 65,
                      width: 65,
                      fit: BoxFit.cover,
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
                    Text(
                      widget.garage.name,
                      style: TextStyle(
                          fontSize: fontSizeL, fontWeight: FontWeight.w600),
                      softWrap: true,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        Text(tPhone + ': '),
                        Text(
                          widget.garage.phone,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(tEmail + ': '),
                        Text(
                          widget.garage.email.toString(),
                        )
                      ],
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
