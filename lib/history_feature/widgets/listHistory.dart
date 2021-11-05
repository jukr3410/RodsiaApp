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
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(RequestServiceLoad());
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
            if (state is RequestServicesLoadSuccess && state != null) {
              _reqServices.addAll(state.requestServices);
              _widget = ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: mockupNotify.length,
                  itemBuilder: (context, index) {
                    return cardNotify(_reqServices[index]);
                  });
            } else if (state is RequestServicesError || state == null) {
              _widget = Center(child: Text('ไม่มีประวัติการใข้งาน!'));
            }
            return _widget;
          }),
    );
  }

  Widget cardNotify(RequestService requestService) {
    return GestureDetector(
      child: Card(
        // shape: RoundedRectangleBorder(borderRadius: borderRadiusMedium),
        elevation: 2,
        margin: new EdgeInsets.symmetric(
            horizontal: defualtPaddingLow - 2, vertical: defualtPaddingLow - 7),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                tImageAsset(requestService.service.serviceType.toString()),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defualtPaddingMedium,
                  // vertical: 10,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        requestService.garage.name,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: new TextStyle(
                            fontSize: fontSizeL - 1,
                            fontWeight: FontWeight.bold,
                            color: textColorBlack),
                      ),
                      Text(
                        requestService.service.name,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            fontSize: fontSizeS - 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Text(
                        DateFormat('yyyy-MMM-dd  HH:MM น.').format(
                            DateTime.parse(
                                requestService.createTime.toString())),
                        style: TextStyle(
                            color: Colors.grey, fontSize: fontSizeS - 2),
                      ),
                    ],
                  ),
                ),
              )),
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
