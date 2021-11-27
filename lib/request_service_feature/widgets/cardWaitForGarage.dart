import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/repository/request_service_repository.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/alertPopupCancleRequest.dart';

class CardWaitForGarage extends StatefulWidget {
  RequestService requestService;
  CardWaitForGarage({Key? key, required this.requestService}) : super(key: key);

  @override
  _CardWaitForGarageState createState() => _CardWaitForGarageState();
}

class _CardWaitForGarageState extends State<CardWaitForGarage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: cardWidthMedium,
            decoration: BoxDecoration(
              borderRadius: borderRadiusMedium,
              boxShadow: [boxShadow],
              color: bgColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(defualtPaddingHight),
              child: Column(
                children: [
                  Text(
                    tWaitForGarageThai,
                    style: TextStyle(fontSize: fontSizeM),
                  ),
                  SizedBox(
                    height: defualtPaddingMedium,
                  ),
                  SpinKitPouringHourGlass(
                    color: primaryColor,
                    duration: Duration(milliseconds: 2000),
                  ),
                  SizedBox(
                    height: defualtPaddingHight,
                  ),
                  Container(
                      height: buttonHeightSmall,
                      width: buttonWidthSmall,
                      child: TextButton(
                        onPressed: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => BlocProvider(
                                  create: (context) => RequestServiceBloc(
                                      requestServiceRepository:
                                          RequestServiceRepository()),
                                  child: AlertPopupCancleReq(
                                    requestServiceId: widget.requestService.id,
                                  )));
                        },
                        child: Text(tCancleThai),
                        style: flatButtonStyle(primaryColor, textColorBlack),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  navigateToConfirmRequest() {
    Navigator.pop(context);
  }
}
