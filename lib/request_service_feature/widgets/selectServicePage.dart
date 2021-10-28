import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/infoGarageFormSelect.dart';
import 'package:rodsiaapp/request_service_feature/widgets/selectServiceOfGarage.dart';

class SelectServicePage extends StatefulWidget {
  final String garageId;
  SelectServicePage({Key? key, required this.garageId}) : super(key: key);

  @override
  _SelectServicePageState createState() => _SelectServicePageState();
}

class _SelectServicePageState extends State<SelectServicePage> {
  late GarageInfoBloc _garageInfoBloc;

  @override
  void initState() {
    _garageInfoBloc = BlocProvider.of<GarageInfoBloc>(context)
      ..add(GarageInfoLoad(widget.garageId));
    super.initState();
  }

  List mockupImage = [
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://images.unsplash.com/photo-1612151855475-877969f4a6cc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aGQlMjBpbWFnZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://images.unsplash.com/photo-1612151855475-877969f4a6cc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aGQlMjBpbWFnZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: setAppBar(),
      body: BlocConsumer<GarageInfoBloc, GarageInfoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is GarageLoadSuccess) {
            return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoGarageFormSelect(garage: state.garage),
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
                                  state.services.length.toString() +
                                  ' ' +
                                  tServiceThai +
                                  ')')
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SelectServiceOfGarage(
                            services: state.services,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          addImageForReq(),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  style: flatButtonStyle(
                                      primaryColor, textColorBlack),
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
                              TextButton(
                                  onPressed: () {},
                                  style: flatButtonStyle(
                                      primaryColor, textColorBlack),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.camera_alt, size: 20),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text('กล้อง'),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            style: TextStyle(fontSize: 12),
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
                                navigateToConfirmRequest();
                              },
                              style:
                                  flatButtonStyle(primaryColor, textColorBlack),
                              child: Text(tNext),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  navigateToConfirmRequest() {
    Navigator.pushNamed(context, CONFIRM_REQUEST_ROUTE,
        arguments: {'garage': null});
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
          Icons.arrow_back,
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
      children: List.generate(
          mockupImage.length,
          (index) => Image.network(
                mockupImage[index].toString(),
                fit: BoxFit.cover,
              )),
    );
  }

  navigateToGarageList() {
    Navigator.pop(context);
  }
}
