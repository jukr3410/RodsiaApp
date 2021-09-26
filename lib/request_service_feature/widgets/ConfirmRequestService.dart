import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/profile_feature/widgets/showInfoCarCard.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ConfirmRequestService extends StatefulWidget {
  Service service;
  ConfirmRequestService({Key? key, required this.service}) : super(key: key);

  @override
  _ConfirmRequestServiceState createState() => _ConfirmRequestServiceState();
}

class _ConfirmRequestServiceState extends State<ConfirmRequestService> {
  late RequestServiceBloc _requestServiceBloc;

  late RequestServiceAdd _requestServiceAdd;

  int selectedIndex = 0;

  List<String> mockupService = ['ยางแตก', 'หม้อน้ำเสีย', 'ระบบไฟฟ้า'];

  Car car = Car(id: "", brand: "", model: "", type: "", year: "", fuelType: "");
  List<Widget> _buildItems() {
    return mockUpCar
        .map((val) => SelectionItem(
              car: val,
            ))
        .toList();
  }

  TextStyle _textTitle = TextStyle(
      color: textColorBlack, fontWeight: FontWeight.w600, fontFamily: 'Kanit');

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context);
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
      // title: Text(
      //   tAddService,
      //   style: TextStyle(color: textColorBlack, fontSize: fontSizeSemiLarge),
      // ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColorBlack,
        ),
        onPressed: () {
          navigateToGarageinfo();
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

  setBody() {
    //_service!.serviceType = ServiceType(id: "1234", name: "134", description: "1234");
    return Center(
        child: BlocConsumer<RequestServiceBloc, RequestServiceState>(
            listener: (context, state) {
      if (state is CreatedRequestService) {
        navigateToWaitingRequest(state.requestServiceId);
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
        child:
            // Container(
            //   width: buttonWidthMedium,
            //   height: buttonHeightMedium,
            //   child:
            //   TextButton(
            //     onPressed: () {
            //       createRequestService();
            //     },
            //     style: flatButtonStyle(primaryColor, textColorBlack),
            //     child: Text(tConfirm),
            //   ),
            // ),
            Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
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
                      car = mockUpCar[selectedIndex];
                      print(car.toJson());
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
              Text('168 Garage'),
              SizedBox(
                height: defualtPaddingLow + 4,
              ),
              Text(
                'บริการที่เลือก' + ':',
                style: _textTitle,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: mockupService.length,
                    itemBuilder: (context, index) => Row(
                          children: [
                            Icon(
                              Icons.report_problem_outlined,
                              size: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(mockupService[index]),
                          ],
                        )),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 1.0,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(color: textColorBlack),
                ),
              ),
              Text(
                'หมายเหตุ' + ':',
                style: _textTitle,
              ),
              Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'ยากแบนเพราะเกิดจากอะไรไม่รู้',
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  )
                ],
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
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
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }

  navigateToGarageinfo() {
    Navigator.pop(context);
  }

  navigateToWaitingRequest(String requestServiceId) {
    Navigator.pushNamed(context, WAITING_REQUEST_ROUTE,
        arguments: {'requestServiceId': requestServiceId});
  }

  createRequestService() {
    _requestServiceBloc
      ..add(CreateRequestService(requestServiceAdd: requestServiceAdd));
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tConfirm + tRequestServiceThai));
    if (result == 'Ok') {
      logger.d("Clicked Confirm Request Service");
      createRequestService();
    }
  }

  final RequestServiceAdd requestServiceAdd = RequestServiceAdd(
      user: '6127927b6582ef63c96d3f6e',
      service: '6126688e8a7cff53caba8026',
      car: Car(
          id: "",
          brand: "brand",
          model: "model",
          type: "type",
          year: "year",
          fuelType: "fuelType"),
      geoLocationGarage: GeoLocation(lat: '13.6561449', long: '100.4958788'),
      geoLocationUser: GeoLocation(lat: '13.6527639', long: '100.4859599'),
      problemDesc: 'ไม่ทราบสาเหตุ',
      confirmRequest: true,
      status: 'กำลังเตรียม');
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
