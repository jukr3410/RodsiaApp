import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/global_widgets/supportButton.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/cardWaitForGarage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class WaitForGaragePage extends StatefulWidget {
  final RequestService requestService;
  WaitForGaragePage({Key? key, required this.requestService}) : super(key: key);

  @override
  _WaitForGaragePageState createState() => _WaitForGaragePageState();
}

class _WaitForGaragePageState extends State<WaitForGaragePage> {
  late RequestServiceBloc _requestServiceBloc;

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(LoadRequestService(requestServiceId: widget.requestService.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestServiceBloc, RequestServiceState>(
      listener: (context, state) {
        if (state is RequestServiceGarageConfirmed) {
          showTopSnackBar(
              context, CustomSnackBar.success(message: "ร้านยืนยันคำขอแล้ว"));
          navigateToTrackingRequest(state.requestService);
        } else if (state is RequestServiceGarageDeny) {
          showTopSnackBar(
              context, CustomSnackBar.info(message: "คำขอถูกปฏิเสธ"));
          navigateToConfirmRequest();
        }
      },
      builder: (context, state) {
        //if (state is RequestServiceWaiting) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: bgColor,
            title: Container(
                alignment: Alignment.centerRight, child: SupportButton()),
          ),
          body: CardWaitForGarage(requestService: widget.requestService),
        );
        //}
        // return Center(
        //     child: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        //   child: CircularProgressIndicator(
        //   valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        // ),
        // ));
      },
    );
  }

  navigateToTrackingRequest(RequestService requestService) {
    Navigator.pushNamed(context, TRACKING_REQUEST_ROUTE,
        arguments: requestService);
  }

  navigateToConfirmRequest() {
    Navigator.pop(context);
  }

  cancelRequestService(requestServiceId) {
    _requestServiceBloc
      ..add(CancelRequestService(requestServiceId: requestServiceId));
  }
}
