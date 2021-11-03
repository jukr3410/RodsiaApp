import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/find_garage_feature/widgets/test.dart';

class TrackingRequestCard extends StatefulWidget {
  RequestServiceAdd requestServiceAdd;
  TrackingRequestCard({Key? key, required this.requestServiceAdd})
      : super(key: key);

  @override
  _TrackingRequestCardState createState() => _TrackingRequestCardState();
}

class _TrackingRequestCardState extends State<TrackingRequestCard> {
  Widget _textInfo(String desc, String image) {
    return Row(
      children: [
        Image.asset(
          tImageAsset(image),
          width: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(
          desc,
          softWrap: true,
          style: _textStyleSmall,
        )),
        SizedBox(
          height: 7,
        ),
      ],
    );
  }

  TextStyle _textStyleSmall = TextStyle(
    fontSize: fontSizeM,
  );
  TextStyle _textStyleBig =
      TextStyle(fontSize: fontSizeXl, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.08,
      decoration: BoxDecoration(
        borderRadius: borderRadiusMedium,
        boxShadow: [boxShadow],
        color: bgColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadiusMediumOnlyTop,
              color: primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(defualtPaddingLow),
              child: Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          tImageAsset('profile2'),
                          width: 27,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: StrutStyle(
                                fontSize: 5,
                              ),
                              text: TextSpan(
                                text: 'BMW center',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: fontSizeXl,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Kanit'),
                              )),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: greenStatus,
                          maxRadius: 5,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.requestServiceAdd.status,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: defualtPaddingMedium, right: defualtPaddingMedium),
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: defualtPaddingMedium,
                          ),
                          Column(
                            children: [
                              Text(
                                tEstimateDuration,
                              ),
                              Text(
                                '10.20 - 10.35',
                                style: _textStyleBig,
                              )
                            ],
                          ),
                          SizedBox(
                            height: defualtPaddingMedium,
                          ),
                          _textInfo(
                            widget.requestServiceAdd.car.type +
                                ' ' +
                                widget.requestServiceAdd.car.brand +
                                ' ' +
                                widget.requestServiceAdd.car.model +
                                ' ' +
                                widget.requestServiceAdd.car.year,
                            'car',
                          ),
                          _textInfo(
                            '2.5 กิโลเมตร',
                            'distance',
                          ),
                          _textInfo(
                            'ถนนพระราม 2 ซอยท่าข้าม 20',
                            'location2',
                          ),
                          _textInfo(
                            widget.requestServiceAdd.problemDesc,
                            'desc',
                          ),
                          SizedBox(
                            height: defualtPaddingLow,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    // alignment: Alignment.topCenter,
                    child: Image.asset(
                      tImageAsset('location-requestCard'),
                      alignment: Alignment.topRight,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: ImageIcon(AssetImage(tImageAsset('call'))),
                  onPressed: () {}),
              SizedBox(
                width: 100,
              ),
              IconButton(
                  icon: ImageIcon(AssetImage(tImageAsset('message'))),
                  onPressed: () {
                    navigatorToChat();
                  }),
            ],
          )
        ],
      ),
    );
  }

  void navigatorToChat() {
    Navigator.pushNamed(context, CHAT_ROUTE);
  }
}
