import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/car_model.dart';
import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
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
        child: Container(
          width: buttonWidthMedium,
          height: buttonHeightMedium,
          child: TextButton(
            onPressed: () {
              createRequestService();
            },
            style: flatButtonStyle(primaryColor, textColorBlack),
            child: Text(tConfirm),
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
      status: 'รอยืนยัน');
}
