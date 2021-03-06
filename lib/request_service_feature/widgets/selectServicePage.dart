import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/dao/user_dao.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/service_in_garage_mode.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';
import 'package:rodsiaapp/global_widgets/alertPleaseInputInfo.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/infoGarageFormSelect.dart';
import 'package:rodsiaapp/request_service_feature/widgets/selectServiceOfGarage.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';

import 'package:image_picker/image_picker.dart';

class SelectServicePage extends StatefulWidget {
  final Garage garage;
  SelectServicePage({Key? key, required this.garage}) : super(key: key);

  @override
  _SelectServicePageState createState() => _SelectServicePageState();
}

class _SelectServicePageState extends State<SelectServicePage> {
  late TextEditingController _controller;

  // List mockupImage = [
  //   'https://www.tqm.co.th/new_images/1478_1.jpg?v=20200722135804',
  //   'https://s359.kapook.com/pagebuilder/f443f787-8814-4b89-afcf-86280b0bdfd8.jpg',
  //   'http://www.tqm.co.th/gallery/5266.jpg',
  // ];

  int val = -1;
  Map<String, bool> test = {};

  var holder_1 = [];

  getItems() {
    test.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  RequestServiceAdd _requestServiceAdd = RequestServiceAdd(
    user: '',
    service: '',
    //garage: '',
    car: Car(
        brand: '',
        model: '',
        type: '',
        year: '',
        fuelType: '',
        regisNumber: ''),
    geoLocationGarage: GeoLocation(lat: '13.6561449', long: '100.4958788'),
    geoLocationUser: GeoLocation(lat: '13.6527639', long: '100.4859599'),
    problemDesc: '',
    confirmRequest: false,
    status: '',
    addressUser: '',
  );

  ComfirmReq cmReq =
      ComfirmReq(garageName: '', serviceName: '', serviceType: '');

  @override
  void initState() {
    _controller = TextEditingController();
    _requestServiceAdd.geoLocationGarage.lat =
        widget.garage.address.geoLocation.lat;
    _requestServiceAdd.geoLocationGarage.long =
        widget.garage.address.geoLocation.long;
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  List<File> _image = [];
  Future getImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    setState(() {
      if (images != null) {
        for (var i = 0; i < images.length; i++) {
          _image.add(File(images[i].path));
        }
      }
    });
  }

  Future getImageCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (image != null) {
        _image.add(File(image.path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: setAppBar(),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InfoGarageFormSelect(garage: widget.garage),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(defualtPaddingLow),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        tServiceOfGarageThai,
                        style: TextStyle(fontSize: fontSizeL),
                      ),
                      Text(' (' +
                          widget.garage.serviceInGarages!.length.toString() +
                          ' ' +
                          tServiceThai +
                          ')')
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.garage.serviceInGarages!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          // margin: new EdgeInsets.symmetric(vertical: 4.0),
                          color: cardColor,
                          child: ListTile(
                            title: _makeCardWidget(
                                widget.garage.serviceInGarages![index]),
                            trailing: Radio(
                                value: index,
                                groupValue: val,
                                onChanged: (int? value) {
                                  setState(() {
                                    val = value!;

                                    _requestServiceAdd.service =
                                        widget.garage.serviceInGarages![val].id;
                                    // _requestServiceAdd.garage =
                                    //     widget.garage.id;

                                    cmReq.garageName = widget.garage.name;
                                    cmReq.serviceType = widget
                                        .garage
                                        .serviceInGarages![val]
                                        .serviceType
                                        .name;
                                    cmReq.serviceName = widget
                                        .garage.serviceInGarages![val].name;
                                    logger.d(widget
                                        .garage.serviceInGarages![index].name);
                                  });
                                }),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  _addImageForReq(),
                  SizedBox(
                    height: 15,
                  ),
                  isGarageOpen(widget.garage) == '????????????'
                      ? Column(
                          children: [
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      getImage();
                                    },
                                    style: flatButtonStyle(
                                        primaryColor, textColorBlack),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.image, size: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('?????????????????????????????????'),
                                      ],
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                    onPressed: () {
                                      getImageCamera();
                                    },
                                    style: flatButtonStyle(
                                        primaryColor, textColorBlack),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.camera_alt, size: 20),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('???????????????'),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextField(
                              style: TextStyle(fontSize: 12),
                              controller: _controller,
                              maxLines: 3,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.all(defualtPaddingLow),
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(),
                                helperText:
                                    '???????????? ?????????????????????, ???????????????????????????, ?????????????????????????????????, ????????????????????????????????????',
                                helperStyle: TextStyle(fontSize: 10),
                                labelText: '?????????????????????????????????????????????????????????',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              // margin: EdgeInsets.only(bottom: defualtPaddingHight+20),
                              width: double.infinity,
                              height: buttonHeightSmall,
                              child: TextButton(
                                onPressed: () {
                                  if (val == -1) {
                                    _showDialog(context);
                                  } else {
                                    _requestServiceAdd.problemDesc =
                                        _controller.text;
                                    logger.d(_requestServiceAdd.toJson());
                                    cmReq.req = _requestServiceAdd;
                                    cmReq.images = _image;
                                    logger.d(cmReq.toString());
                                    navigateToConfirmRequest();
                                  }
                                },
                                style: flatButtonStyle(
                                    primaryColor, textColorBlack),
                                child: Text(tNext),
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: Text(
                          '?????????????????????...',
                          style: TextStyle(fontSize: fontSizeXl),
                        ))
                ],
              ),
            ),
          ]),
        ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertPleaseInputInfo();
      },
    );
  }

  navigateToConfirmRequest() {
    Navigator.pushNamed(context, CONFIRM_REQUEST_ROUTE, arguments: cmReq);
  }

  navigateToMoreInfo() {
    Navigator.pushNamed(context, MOREINFO_GARAGE_ROUTE,
        arguments: widget.garage);
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: false,
      title: Container(
        alignment: Alignment.centerRight,
        child: GFButton(
          type: GFButtonType.transparent,
          textStyle: TextStyle(fontSize: 16, color: textColorBlack),
          child: Text(
            tMoreInfoGarage,
            style: TextStyle(fontFamily: 'Kanit'),
          ),
          onPressed: () {
            logger.d(tMoreInfoGarage);
            navigateToMoreInfo();
          },
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: iconColorBlack,
        ),
        onPressed: () {
          navigateToGarageList();
        },
      ),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.add, color: iconColorBlack),
        //   onPressed: () {},
        //   iconSize: 30.0,
        // ),
      ],
    );
  }

  _addImageForReq() {
    if (_image.length > 0) {
      return GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        shrinkWrap: true,
        children: List.generate(_image.length, (index) {
          File image = _image[index];
          return Image.file(
            image,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          );
        }),
      );
    } else {
      return SizedBox();
    }
  }

  navigateToGarageList() {
    Navigator.pop(context);
  }

  _makeCardWidget(ServiceInGarage service) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            tImageAsset(service.serviceType.name),
            width: 35,
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  maxLines: 1,
                  softWrap: false,
                  style: new TextStyle(
                      fontSize: fontSizeM,
                      fontWeight: FontWeight.w600,
                      color: textColorBlack),
                ),
                Container(
                  child: Text(
                    service.description.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                        fontSize: fontSizeS,
                        fontWeight: FontWeight.normal,
                        color: textColorBlack),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
      onTap: () {},
    );
  }

  String isGarageOpen(Garage garage) {
    DateTime now = DateTime.now();

    // logger.d(now.hour.toString() +
    //     ":" +
    //     now.minute.toString() +
    //     ":" +
    //     now.second.toString() +
    //     ", day: " +
    //     now.weekday.toString());
    var openGarage = garage.openingHour!.open.split(".");
    var closeGarage = garage.openingHour!.close.split(".");
    // logger.d(openGarage);
    var openHour = int.parse(openGarage[0]);
    var openMinute = int.parse(openGarage[1]);
    var closeHour = int.parse(closeGarage[0]);
    var closeMinute = int.parse(closeGarage[1]);

    var status = "?????????";
    var textColor = textColorRed;

    switch (now.weekday) {
      case 1:
        if ((garage.openingDayOfWeek!.mo == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "????????????";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "?????????";
            textColor = textColorRed;
          }
        }
        break;
      case 2:
        if ((garage.openingDayOfWeek!.tu == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "????????????";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "?????????";
            textColor = textColorRed;
          }
        }
        break;
      case 3:
        if ((garage.openingDayOfWeek!.we == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "????????????";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "?????????";
            textColor = textColorRed;
          }
        }
        break;
      case 4:
        if ((garage.openingDayOfWeek!.th == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "????????????";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "?????????";
            textColor = textColorRed;
          }
        }
        break;
      case 5:
        if ((garage.openingDayOfWeek!.fr == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "????????????";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "?????????";
            textColor = textColorRed;
          }
        }
        break;
      case 6:
        if ((garage.openingDayOfWeek!.sa == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "????????????";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "?????????";
            textColor = textColorRed;
          }
        }
        break;
      case 7:
        if ((garage.openingDayOfWeek!.su == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "????????????";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "?????????";
            textColor = textColorRed;
          }
        }
        break;
    }
    return status;
  }
}

class ComfirmReq {
  String garageName;
  String serviceName;
  String serviceType;
  RequestServiceAdd? req;
  List<File>? images;

  ComfirmReq(
      {required this.garageName,
      this.req,
      required this.serviceName,
      required this.serviceType,
      this.images});
}
