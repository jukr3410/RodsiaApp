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

  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  RequestServiceAdd _requestServiceAdd = RequestServiceAdd(
    user: '',
    service: '',
    //garage: '',
    car: Car(
        id: '',
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

  ComfirmReq cmReq = ComfirmReq(garageName: '', serviceName: '');

  @override
  void initState() {
    _controller = TextEditingController();
    _requestServiceAdd.geoLocationGarage.lat =
        widget.garage.address.geoLocation.lat;
    _requestServiceAdd.geoLocationGarage.long =
        widget.garage.address.geoLocation.long;
    super.initState();
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
                          widget.garage.services!.length.toString() +
                          ' ' +
                          tServiceThai +
                          ')')
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: widget.garage.services!.length < 6 ? null : 320,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.garage.services!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3,
                            // margin: new EdgeInsets.symmetric(vertical: 4.0),
                            color: cardColor,
                            child: ListTile(
                              title: _makeCardWidget(
                                  widget.garage.services![index]),
                              trailing: Radio(
                                  value: index,
                                  groupValue: val,
                                  onChanged: (int? value) {
                                    setState(() {
                                      val = value!;

                                      _requestServiceAdd.service =
                                          widget.garage.services![val].id;
                                      // _requestServiceAdd.garage =
                                      //     widget.garage.id;

                                      cmReq.garageName = widget.garage.name;
                                      cmReq.serviceName =
                                          widget.garage.services![val].name;
                                      logger.d(
                                          widget.garage.services![index].name);
                                    });
                                  }),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  addImageForReq(),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            loadAssets();
                          },
                          style: flatButtonStyle(primaryColor, textColorBlack),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.image, size: 20),
                              SizedBox(
                                width: 5,
                              ),
                              Text('เพิ่มรูปภาพ'),
                            ],
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      // TextButton(
                      //     onPressed: () {},
                      //     style: flatButtonStyle(primaryColor, textColorBlack),
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         Icon(Icons.camera_alt, size: 20),
                      //         SizedBox(
                      //           width: 5,
                      //         ),
                      //         Text('กล้อง'),
                      //       ],
                      //     )),
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
                      contentPadding: EdgeInsets.all(defualtPaddingLow),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      helperText:
                          'เช่น ยางรั่ว, ยางระเบิด, เบรคไม่อยู่, สตาร์ทไม่ติด',
                      helperStyle: TextStyle(fontSize: 10),
                      labelText: 'รายละเอียดเพิ่มเติม',
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
                          _requestServiceAdd.problemDesc = _controller.text;
                          logger.d(_requestServiceAdd.toJson());
                          cmReq.req = _requestServiceAdd;
                          cmReq.images = images;
                          logger.d(cmReq.toString());
                          navigateToConfirmRequest();
                        }
                      },
                      style: flatButtonStyle(primaryColor, textColorBlack),
                      child: Text(tNext),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          statusBarColor: '#808080',
          actionBarColor: '#38454C',
          actionBarTitle: "เลือกรูปภาพ",
          allViewTitle: "รูปทั้งหมด",
          useDetailsView: false,
          selectCircleStrokeColor: "#FECE2F",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
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

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        'เลือก' + tServiceOfGarageThai,
        style: TextStyle(color: textColorBlack, fontSize: fontSizeL),
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

  Widget addImageForReq() {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      shrinkWrap: true,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset);
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  navigateToGarageList() {
    Navigator.pop(context);
  }

  _makeCardWidget(Service service) {
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
}

class ComfirmReq {
  String garageName;
  String serviceName;
  RequestServiceAdd? req;
  List<Asset>? images;

  ComfirmReq(
      {required this.garageName,
      this.req,
      required this.serviceName,
      this.images});
}
