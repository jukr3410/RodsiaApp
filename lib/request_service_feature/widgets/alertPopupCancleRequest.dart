import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';

class AlertPopupCancleReq extends StatefulWidget {
  String requestServiceId;
  AlertPopupCancleReq({Key? key, required this.requestServiceId})
      : super(key: key);

  @override
  _AlertPopupCancleReqState createState() => _AlertPopupCancleReqState();
}

class _AlertPopupCancleReqState extends State<AlertPopupCancleReq> {
  late RequestServiceBloc _requestServiceBloc;

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidthMedium,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tYouWantCancleThai,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: defualtPaddingMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: buttonHeightSmall,
                      width: buttonWidthSmall,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'OK');
                          //navigateToConfirmRequest();
                          cancelRequestService(widget.requestServiceId);
                        },
                        child: Text(tOKThai),
                        style: flatButtonStyle(primaryColor, textColorBlack),
                      )),
                  GFButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: Text(tCancleThai),
                    textColor: textColorBlack,
                    type: GFButtonType.transparent,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  navigateToConfirmRequest() {
    Navigator.pop(context);
  }

  cancelRequestService(requestServiceId) {
    logger.d("cancelRequestService: $requestServiceId");
    _requestServiceBloc
        .add(CancelRequestService(requestServiceId: requestServiceId));

    navigateToConfirmRequest();
  }
}
