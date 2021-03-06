import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GarageFormSearch extends StatefulWidget {
  final String garageName;
  const GarageFormSearch({Key? key, required this.garageName})
      : super(key: key);

  @override
  _GarageFormSearchState createState() => _GarageFormSearchState();
}

class _GarageFormSearchState extends State<GarageFormSearch> {
  ScrollController scrollController = ScrollController();
  late GarageListBloc _garageListBloc;

  List<Garage> _garages = [];

  @override
  void initState() {
    _garageListBloc = BlocProvider.of<GarageListBloc>(context)
      ..add(GarageSearchListFetchEvent(nameGarage: widget.garageName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColorBlack),
        title: Text(
          'ร้านที่ค้นหา: ' + widget.garageName,
          style: TextStyle(color: textColorBlack, fontSize: fontSizeL),
        ),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: BlocConsumer<GarageListBloc, GarageListState>(
          listener: (context, garageState) {
            if (garageState is GarageListLoadingState) {
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text(garageState.message)));

            } else if (garageState is GarageListSuccessState &&
                garageState.garages.isEmpty) {
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text('No more garages')));
            } else if (garageState is GarageListErrorState) {
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text(garageState.error)));

              showTopSnackBar(
                context,
                CustomSnackBar.error(
                  message: mError,
                ),
              );
              _garageListBloc.isFetching = false;
            }
            return;
          },
          builder: (context, garageState) {
            if (garageState is GarageListInitialState ||
                garageState is GarageListLoadingState && _garages.isEmpty) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: _shimmer(),
              ));
            } else if (garageState is GarageListSuccessState) {
              _garages = garageState.garages;
              _garageListBloc.isFetching = false;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            } else if (garageState is GarageListErrorState &&
                _garages.isEmpty) {
              return Center(
                  child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      _garageListBloc
                        ..isFetching = true
                        ..add(GarageSearchListFetchEvent(
                            nameGarage: widget.garageName));
                    },
                    icon: Icon(Icons.refresh),
                  ),
                  const SizedBox(height: 15),
                  Text(garageState.error, textAlign: TextAlign.center),
                ],
              ));
            }
            return ListView.builder(
              controller: scrollController
                ..addListener(() {
                  if (scrollController.offset ==
                          scrollController.position.maxScrollExtent &&
                      !_garageListBloc.isFetching) {
                    _garageListBloc
                      ..isFetching = true
                      ..add(GarageSearchListFetchEvent(
                          nameGarage: widget.garageName));
                  }
                }),
              itemBuilder: (context, index) =>
                  _makeCardWidget(_garages[index], index),
              itemCount: _garages.length,
            );
          },
        ),
      ),
    );
  }

  _makeCardWidget(Garage garage, int index) {
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
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                child: ClipOval(
                  child: Image.network(
                    garage.logoImage,
                    width: 110,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
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
                      Container(
                        width: 200,
                        child: Text(
                          garage.name,
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          style: new TextStyle(
                              fontSize: fontSizeL,
                              fontWeight: FontWeight.bold,
                              color: textColorBlack),
                        ),
                      ),
                      Row(children: [
                        Text(
                          "ระยะทาง: " + garage.distance.toString(),
                          style: new TextStyle(
                              fontSize: fontSizeM,
                              fontWeight: FontWeight.normal,
                              color: textColorBlack),
                        ),
                        Text(
                          " | ",
                          style: new TextStyle(
                              fontSize: fontSizeM,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54),
                        ),
                        Icon(
                          Icons.star,
                          color: primaryColor,
                          size: 20,
                        ),
                        Text(
                          " " + garage.reviewStar.toString(),
                          style: new TextStyle(
                              fontSize: fontSizeM,
                              fontWeight: FontWeight.normal,
                              color: textColorBlack),
                        ),
                      ]),
                      Container(
                        width: 200,
                        height: 25,
                        child: Row(
                          children: [
                            Text(
                              tServiceThai + ': ',
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: garage.typeCarRepairs.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Image.asset(
                                        tImageAsset(
                                            garage.typeCarRepairs[index].type),
                                        width: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  );
                                }),
                            Text('  |  '),
                            ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: garage.serviceInGarages!.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Image.asset(
                                        tImageAsset(garage
                                            .serviceInGarages![index]
                                            .serviceType
                                            .name),
                                        width: 18,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isGarageOpen(garage)
                          // Text(
                          //   'close',
                          //   style: TextStyle(
                          //       fontSize: fontSizeM,
                          //       fontWeight: FontWeight.normal,
                          //       color: textColorRed),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          //   child: Icon(Icons.data_usage),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
      onTap: () {
        navigateToGarageInfo(garage);
      },
    );
  }

  Widget showIconServiceT(List<Service> service) {
    return service.length == 0
        ? Text('ไม่มี')
        : Image.asset(
            tImageAsset(service[0].serviceType.name),
            width: 18,
          );
  }

  _shimmer() {
    return Shimmer.fromColors(
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: 6,
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100);
  }

  void navigateToGarageInfo(Garage garage) {
    Navigator.pushNamed(context, GARAGE_INFO_ROUTE, arguments: garage);
  }

  isGarageOpen(Garage garage) {
    DateTime now = DateTime.now();

    // logger.d(now.hour.toString() +
    //     ":" +
    //     now.minute.toString() +
    //     ":" +
    //     now.second.toString() +
    //     ", day: " +
    //     now.weekday.toString());
    var openGarage = garage.openingHour!.open.split(".");
    var closeGarage = garage.openingHour!.close.split(".");
    // logger.d(openGarage);
    var openHour = int.parse(openGarage[0]);
    var openMinute = int.parse(openGarage[1]);
    var closeHour = int.parse(closeGarage[0]);
    var closeMinute = int.parse(closeGarage[1]);

    var status = "ปิด";
    var textColor = textColorRed;

    switch (now.weekday) {
      case 1:
        if ((garage.openingDayOfWeek!.mo == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 2:
        if ((garage.openingDayOfWeek!.tu == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 3:
        if ((garage.openingDayOfWeek!.we == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 4:
        if ((garage.openingDayOfWeek!.th == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 5:
        if ((garage.openingDayOfWeek!.fr == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 6:
        if ((garage.openingDayOfWeek!.sa == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 7:
        if ((garage.openingDayOfWeek!.su == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
    }

    return Text(
      status,
      style: TextStyle(
          fontSize: fontSizeM, fontWeight: FontWeight.normal, color: textColor),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
