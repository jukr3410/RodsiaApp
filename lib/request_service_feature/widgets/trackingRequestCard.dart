import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class TrackingRequestCard extends StatefulWidget {
  RequestService req;
  String duration;
  String distance;
  TrackingRequestCard(
      {Key? key,
      required this.req,
      required this.duration,
      required this.distance})
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(defualtPaddingLow),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadiusMedium,
                boxShadow: [boxShadow],
                color: bgColor,
              ),
              child: Column(
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
                          Expanded(
                            flex: 8,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defualtPaddingLow),
                                  child: Image.asset(
                                    tImageAsset(
                                        widget.req.service.serviceType.name),
                                    width: 27,
                                  ),
                                ),
                                RichText(
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: StrutStyle(
                                      fontSize: 5,
                                    ),
                                    text: TextSpan(
                                      text: widget.req.service.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: fontSizeXl,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Kanit'),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerRight,
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
                                    widget.req.status,
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: defualtPaddingMedium,
                        left: defualtPaddingMedium,
                        top: defualtPaddingLow,
                        bottom: defualtPaddingLow),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.supervised_user_circle,
                                    color: textColorBlack,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      widget.req.service.garage!.name,
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: _textStyleSmall,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    tImageAsset(widget.req.car.type),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            widget.req.car.brand,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            widget.req.car.model,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            widget.req.car.year,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('ป้ายทะเบียน: '),
                                          Text(
                                            widget.req.car.regisNumber,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    tImageAsset('distance'),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.distance,
                                    softWrap: true,
                                    style: _textStyleSmall,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    tImageAsset('location2'),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 180,
                                    child: Text(
                                      widget.req.addressUser,
                                      softWrap: true,
                                      style: _textStyleSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    tImageAsset('desc'),
                                    width: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  widget.req.problemDesc.isEmpty
                                      ? Text('ไม่มีรายละเอียดเพิ่มเติม')
                                      : Container(
                                          width: 180,
                                          child: Text(
                                            widget.req.problemDesc,
                                            softWrap: true,
                                            style: _textStyleSmall,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: textColorBlack,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  widget.req.image == null
                                      ? Text('ไม่มีรูป')
                                      : Container(
                                          height: 40,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount:
                                                  widget.req.image!.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    GestureDetector(
                                                      child: CachedNetworkImage(
                                                        width: 40,
                                                        height: 40,
                                                        fit: BoxFit.cover,
                                                        imageUrl: widget
                                                            .req.image![index],
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(
                                                          color: textColorBlack,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                      onTap: () {
                                                        _navigateAndDisplayImage(
                                                            context,
                                                            widget.req
                                                                .image![index]);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    )
                                                  ],
                                                );
                                              })),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      tEstimateDuration,
                                    ),
                                    Text(
                                      widget.duration +
                                          ' - ' +
                                          (double.parse(widget.duration) + 5)
                                              .toStringAsFixed(0) +
                                          " นาที",
                                      style: _textStyleBig,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: textColorBlack),
                                    child: IconButton(
                                      icon: Icon(Icons.call),
                                      onPressed: () {
                                        UrlLauncher.launch(
                                            'tel://${widget.req.service.garage!.phone}');
                                      },
                                      color: primaryColor,
                                    )),
                                Text(
                                  'โทรสอบถาม',
                                  style: TextStyle(fontSize: fontSizeS),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showFullImage(String image) {
    return Center(
      child: Container(
        width: cardWidthLow,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: CachedNetworkImage(
          // height: double.infinity,
          alignment: Alignment.center,
          width: 300,
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) => CircularProgressIndicator(
            color: textColorBlack,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  void _navigateAndDisplayImage(BuildContext context, String image) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => _showFullImage(image));
    if (result == 'Ok') {}
  }

  void navigatorToChat() {
    Navigator.pushNamed(context, CHAT_ROUTE);
  }
}
