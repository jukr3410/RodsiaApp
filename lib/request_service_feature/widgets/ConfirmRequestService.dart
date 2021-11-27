import 'dart:io';

import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/core/models/user_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/bloc/profile_bloc.dart';
import 'package:rodsiaapp/profile_feature/widgets/showInfoCarCard.dart';
import 'package:rodsiaapp/request_service_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';
import 'package:rodsiaapp/request_service_feature/bloc/service_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/selectServicePage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ConfirmRequestService extends StatefulWidget {
  ComfirmReq req;
  ConfirmRequestService({Key? key, required this.req}) : super(key: key);

  @override
  _ConfirmRequestServiceState createState() => _ConfirmRequestServiceState();
}

class _ConfirmRequestServiceState extends State<ConfirmRequestService> {
  late RequestServiceBloc _requestServiceBloc;
  late ServiceBloc _serviceBloc;
  late GarageInfoBloc _garageInfoBloc;
  late ProfileBloc _profileBloc;

  String _requestServiceId = '';

  User _user = mockUpUser;

  int selectedIndex = 0;

  late Widget _garageName;
  late Widget _serviceName;

  List<Widget> _buildItems() {
    return _user.cars!
        .map((val) => SelectionItem(
              car: val,
            ))
        .toList();
  }

  TextStyle _textTitle = TextStyle(
      color: textColorBlack, fontWeight: FontWeight.w600, fontFamily: 'Kanit');

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(GetCurrentLocationAndAddress());
    _serviceBloc = BlocProvider.of<ServiceBloc>(context)
      ..add(ServiceFetchEvent(serviceId: widget.req.serviceName));
    _garageInfoBloc = BlocProvider.of<GarageInfoBloc>(context)
      ..add(GarageInfoLoad(garageId: widget.req.garageName));
    _profileBloc = BlocProvider.of<ProfileBloc>(context)
      ..add(ProfileLoadFormPhone());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(),
      body: setBody(),
    );
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        'สรุปรายการขอบริการ',
        style: TextStyle(color: textColorBlack, fontSize: fontSizeL),
      ),
      iconTheme: IconThemeData(color: textColorBlack),
    );
  }

  setBody() {
    //_service!.serviceType = ServiceType(id: "1234", name: "134", description: "1234");
    return BlocConsumer<RequestServiceBloc, RequestServiceState>(
        listener: (context, state) {
      if (state is CreatedRequestService) {
        _requestServiceId = state.requestServiceId;
        navigateToWaitingRequest(state.requestServiceId);
        // showTopSnackBar(
        //     context, CustomSnackBar.success(message: ""));
      }
      if (state is CreateRequestServiceError) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: mError,
          ),
        );
      }
      if (state is CurrentLocationAndAddressSuccess) {
        logger.d(
            "current location: ${state.position.latitude.toString()}, ${state.position.longitude.toString()}");
        logger.d("current address: ${state.address}");
        widget.req.req!.geoLocationUser.lat =
            state.position.latitude.toString();
        widget.req.req!.geoLocationUser.long =
            state.position.longitude.toString();
        widget.req.req!.addressUser = state.address!;
      }
    }, builder: (context, state) {
      return BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is UserLoadSuccess) {
            setState(() {
              _user = state.user;
            });
            if (_user.cars!.isEmpty) {
              _navigateToAddCar(context);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _user.cars!.isEmpty
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(defualtPaddingHight),
                        child: Text(
                          'ไม่มีรถ!',
                          style: TextStyle(fontSize: fontSizeXl),
                        ),
                      ))
                    : Column(
                        children: [
                          Text(tSelectCarForRequest + ':', style: _textTitle),
                          SizedBox(
                            height: 5,
                          ),
                          ShowInfoCarCard(car: _user.cars![selectedIndex]),
                          SizedBox(
                            height: 5,
                          ),
                          DirectSelect(
                              itemExtent: 40.0,
                              backgroundColor: bgColor,
                              selectedIndex: selectedIndex,
                              mode: DirectSelectMode.drag,
                              child: SelectionItem(
                                isForList: false,
                                car: _user.cars![selectedIndex],
                              ),
                              onSelectedItemChanged: (int? index) {
                                setState(() {
                                  selectedIndex = index!;
                                  widget.req.req!.car =
                                      _user.cars![selectedIndex];
                                  print(widget.req.req!.car.toJson());
                                });
                              },
                              items: _buildItems()),
                        ],
                      ),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Text(
                  tLocationCurrent + ':',
                  style: _textTitle,
                ),
                Row(
                  children: [
                    Icon(Icons.map, size: 15),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.req.req!.addressUser,
                      softWrap: true,
                      maxLines: 3,
                    ),
                  ],
                ),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Text(
                  'ร้านผู้ให้บริการ:',
                  style: _textTitle,
                ),
                Text(widget.req.garageName),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Text(
                  'บริการที่เลือก' + ':',
                  style: _textTitle,
                ),
                Text(widget.req.serviceName),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Text(
                  'ประเภท' + ':',
                  style: _textTitle,
                ),
                Text(widget.req.serviceType),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Text(
                  'รูปภาพประกอบ' + ':',
                  style: _textTitle,
                ),
                SizedBox(
                  height: 5,
                ),
                _addImageForReq(),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Text(
                  'หมายเหตุ' + ':',
                  style: _textTitle,
                ),
                widget.req.req!.problemDesc.isEmpty
                    ? Text('ไม่มีรายละเอียดเพิ่มเติม')
                    : Text(
                        widget.req.req!.problemDesc,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: defualtPaddingMedium),
                  height: buttonHeightSmall + 5,
                  width: buttonWidthLarge,
                  child: TextButton(
                    onPressed: () {
                      _navigateAndDisplaySelection(context);
                    },
                    child: Text(tRequestServiceThai),
                    style: flatButtonStyle(primaryColor, textColorBlack),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _addImageForReq() {
    if (widget.req.images!.length > 0) {
      return GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        shrinkWrap: true,
        children: List.generate(widget.req.images!.length, (index) {
          File image = widget.req.images![index];
          return Image.file(
            image,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          );
        }),
      );
    } else {
      return Text('ไม่มีรูปภาพเพิ่มเติม');
    }
  }

  navigateToGarageinfo() {
    Navigator.pop(context);
  }

  navigateToWaitingRequest(requestServiceId) {
    Navigator.pushNamed(context, WAITING_REQUEST_ROUTE,
        arguments: {'requestServiceId': requestServiceId});
  }

  createRequestService() {
    _requestServiceBloc
      ..add(CreateRequestService(
          requestServiceAdd: widget.req.req!,
          images: widget.req.images!.isEmpty ? null : widget.req.images));
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tConfirm + tRequestServiceThai));
    if (result == 'Ok') {
      logger.d("Clicked Confirm Request Service");
      //widget.req.req!.createdAt = DateTime.now();
      widget.req.req!.car = _user.cars![selectedIndex];
      logger.d(widget.req.req!.toJson());
      await createRequestService();
      //navigateToWaitingRequest(_requestServiceId);
    }
  }

  void _navigateToAddCar(BuildContext context) async {
    final result = await showDialog<String>(
        context: context, builder: (BuildContext context) => AlertToAddCar());
    if (result == 'Ok') {
      navigatorToAddCar();
    }
  }

  void navigatorToAddCar() {
    Navigator.pushNamed(context, ADDCAR_CARTYPE_ROUTE, arguments: _user);
  }
}

class SelectionItem extends StatelessWidget {
  final Car car;
  final bool isForList;

  const SelectionItem({Key? key, required this.car, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              elevation: 5,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(defualtPaddingLow)),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    TextStyle _textStyle = TextStyle(fontSize: 15, fontFamily: 'Kanit');
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(car.brand, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text(car.model, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text(car.year, style: _textStyle),
          SizedBox(
            width: 5,
          ),
          Text('(${car.fuelType})', style: _textStyle)
        ],
      ),
    );
  }
}

class AlertToAddCar extends StatelessWidget {
  const AlertToAddCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: cardWidthLow,
          decoration: BoxDecoration(
            borderRadius: borderRadiusMedium,
            boxShadow: [boxShadow],
            color: bgColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(defualtPaddingLow),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'คุณต้องเพิ่มรถ!',
                  style: TextStyle(
                      fontSize: fontSizeL,
                      color: textColorBlack,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Kanit'),
                ),
                SizedBox(
                  height: defualtPaddingLow,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: buttonHeightSmall,
                        width: buttonWidthSmall,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Ok');
                          },
                          child: Text(tOKThai),
                          style: flatButtonStyle(primaryColor, textColorBlack),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
