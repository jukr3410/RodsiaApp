import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/main.dart';
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

  int selectedIndex = 0;

  late Widget _garageName;
  late Widget _serviceName;

  List<Widget> _buildItems() {
    return mockUpCar
        .map((val) => SelectionItem(
              car: val,
            ))
        .toList();
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

  TextStyle _textTitle = TextStyle(
      color: textColorBlack, fontWeight: FontWeight.w600, fontFamily: 'Kanit');

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context);
    ServiceBloc _serviceBloc = BlocProvider.of<ServiceBloc>(context)
      ..add(ServiceFetchEvent(serviceId: widget.req.serviceName));
    GarageInfoBloc _garageInfoBloc = BlocProvider.of<GarageInfoBloc>(context)
      ..add(GarageInfoLoad(garageId: widget.req.garageName));
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
    return Center(
        child: BlocConsumer<RequestServiceBloc, RequestServiceState>(
            listener: (context, state) {
      if (state is CreatedRequestService) {
        navigateToWaitingRequest(widget.req.req!);
        // showTopSnackBar(
        //     context, CustomSnackBar.success(message: ""));
      } else if (state is CreateRequestServiceError) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: mError,
          ),
        );
      }
    }, builder: (context, state) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tSelectCarForRequest + ':', style: _textTitle),
                SizedBox(
                  height: 5,
                ),
                ShowInfoCarCard(car: mockUpCar[selectedIndex]),
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
                      car: mockUpCar[selectedIndex],
                    ),
                    onSelectedItemChanged: (int? index) {
                      setState(() {
                        selectedIndex = index!;
                        widget.req.req!.car = mockUpCar[selectedIndex];
                        print(widget.req.req!.car.toJson());
                      });
                    },
                    items: _buildItems()),
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
                      '23456 แขวงนู่น เขตนี่',
                      softWrap: true,
                      maxLines: 3,
                    ),
                  ],
                ),
                SizedBox(
                  height: defualtPaddingLow + 4,
                ),
                Text(
                  'ร้านผู้ให้บริการ:',
                  style: _textTitle,
                ),
                Text(widget.req.garageName),
                SizedBox(
                  height: defualtPaddingLow + 4,
                ),
                Text(
                  'บริการที่เลือก' + ':',
                  style: _textTitle,
                ),
                Text(widget.req.serviceName),
                SizedBox(
                  height: defualtPaddingLow + 4,
                ),
                Text(
                  'รูปภาพประกอบ' + ':',
                  style: _textTitle,
                ),
                SizedBox(
                  height: 5,
                ),
                addImageForReq(),
                SizedBox(
                  height: defualtPaddingLow + 4,
                ),
                Text(
                  'หมายเหตุ' + ':',
                  style: _textTitle,
                ),
                Text(
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
    }));
  }

  Widget addImageForReq() {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      shrinkWrap: true,
      children: List.generate(widget.req.images!.length, (index) {
        Asset asset = widget.req.images![index];
        print(asset);
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  navigateToGarageinfo() {
    Navigator.pop(context);
  }

  navigateToWaitingRequest(RequestServiceAdd requestServiceAdd) {
    Navigator.pushNamed(context, WAITING_REQUEST_ROUTE,
        arguments: requestServiceAdd);
  }

  createRequestService() {
    _requestServiceBloc
      ..add(CreateRequestService(requestServiceAdd: widget.req.req!));
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tConfirm + tRequestServiceThai));
    if (result == 'Ok') {
      logger.d("Clicked Confirm Request Service");
      widget.req.req!.createdAt = DateTime.now();
      logger.d(widget.req.req!.toJson());
      createRequestService();
      navigateToWaitingRequest(widget.req.req!);
    }
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
