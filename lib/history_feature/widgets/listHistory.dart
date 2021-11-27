import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/history_feature/bloc/request_service_bloc.dart';

class Listhistory extends StatefulWidget {
  const Listhistory({Key? key}) : super(key: key);

  @override
  _ListhistoryState createState() => _ListhistoryState();
}

class _ListhistoryState extends State<Listhistory> {
  late RequestServiceBloc _requestServiceBloc;
  List<RequestService> _reqServices = [];
  Widget _widget = Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
    ),
  );

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(RequestServiceWithStatus(status: 'งานเสร็จแล้ว'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text('ประวัติการใช้งาน'),
        iconTheme: IconThemeData(color: textColorBlack),
        titleTextStyle: TextStyle(
            color: textColorBlack, fontSize: fontSizeXl, fontFamily: 'Kanit'),
      ),
      body: BlocConsumer<RequestServiceBloc, RequestServiceState>(
          listener: (context, state) {},
          builder: (context, state) {
            print(state.toString());
            if (state is RequestServicesLoadSuccess) {
              _reqServices = state.requestServices;
              _widget = ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _reqServices.length,
                  itemBuilder: (context, index) {
                    return cardNotify(_reqServices[index]);
                  });
              if (state.requestServices.isEmpty) {
                _widget = Center(child: Text('ไม่มีประวัติการใข้งาน!'));
              }
            } else if (state is RequestServicesError) {
              _widget = Center(child: Text('ไม่มีประวัติการใข้งาน!'));
            }
            return _widget;
          }),
    );
  }

  Widget cardNotify(RequestService requestService) {
    return GestureDetector(
      child: Card(
        elevation: 2,
        margin: new EdgeInsets.symmetric(
            horizontal: defualtPaddingLow - 2, vertical: defualtPaddingLow - 7),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                tImageAsset(requestService.service.serviceType.name),
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    requestService.service.name,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: new TextStyle(
                        fontSize: fontSizeXl - 1,
                        fontWeight: FontWeight.bold,
                        color: textColorBlack),
                  ),
                  Text(
                    requestService.user.name,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: new TextStyle(
                        fontSize: fontSizeM - 1,
                        fontWeight: FontWeight.bold,
                        color: textColorBlack),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat('dd-MMM-yyyy | HH:MM น.').format(
                            DateTime.parse(
                                requestService.createdAt.toString())),
                        style: TextStyle(
                            color: textColorBlack, fontSize: fontSizeM - 2),
                      ),
                      Text(" ~ "),
                      Text(
                        "12 กก.",
                        style: TextStyle(
                          color: textColorBlack,
                          fontSize: fontSizeM - 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, HISTORY_INFO_ROUTE,
            arguments: requestService);
      },
    );
  }
}
