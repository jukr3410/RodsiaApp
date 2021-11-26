import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/services/geo_location_service.dart';
import 'package:rodsiaapp/core/services/marker.dart';
import 'package:rodsiaapp/find_garage_feature/bloc/garage_bloc.dart';
import 'package:rodsiaapp/main.dart';

import '../../secrets.dart';

class MapView extends StatefulWidget {
  final FilterGarageModel? filter;
  MapView({required this.filter});
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController _mapController;
  late GarageListBloc _garageListBloc;

  late Position currentPosition;

  final geoService = GeoLocatorService();
  final markerService = MarkerService();

  Garage? _garageShow;

  final List<Garage> _garages = [];
  List<Marker> markers = <Marker>[];

  BitmapDescriptor? customIcon1;

  @override
  void initState() {
    super.initState();
    _garageListBloc = BlocProvider.of<GarageListBloc>(context)
      ..add(GetCurrentLocation())
      ..add(GarageListFetchEvent(
        filter: widget.filter!,
      ));
  }

  createMarker(context) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      BitmapDescriptor.fromAssetImage(
              configuration, 'assets/images/car-repair.png')
          .then((icon) {
        setState(() {
          customIcon1 = icon;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: BlocConsumer<GarageListBloc, GarageListState>(
        listener: (context, state) {
          if (state is CurrentLocationSuccess) {
            currentPosition = state.position;
          } else if (state is GarageListSuccessState) {
            _garages.addAll(state.garages);
            markers = getMarkers(_garages, customIcon1!);
          }
        },
        builder: (context, state) {
          if (state is GarageListInitialState ||
              state is GarageListLoadingState ||
              state is MapLoading) {
            createMarker(context);
            return Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: CircularProgressIndicator(),
            ));
          } else if (state is MapError || state is GarageListErrorState) {
            return Center(
                child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    _garageListBloc..add(GetCurrentLocation());
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(mError, textAlign: TextAlign.center),
              ],
            ));
          } else if (state is! GarageListErrorState) {
            return Stack(
              children: <Widget>[
                // Map View
                // GoogleMap(
                //   markers: Set<Marker>.from(markers),
                //   initialCameraPosition: _initialLocation,
                //   myLocationEnabled: true,
                //   myLocationButtonEnabled: false,
                //   mapType: MapType.normal,
                //   zoomGesturesEnabled: true,
                //   zoomControlsEnabled: false,
                //   onMapCreated: (GoogleMapController controller) {
                //     _mapController = controller;
                //   },
                // ),

                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentPosition.latitude, currentPosition.longitude),
                      zoom: 14.0),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  //myLocationButtonEnabled: false,
                  zoomGesturesEnabled: false,
                  markers: Set<Marker>.of(markers),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
                // Show zoom buttons
                SafeArea(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: primaryColor, // button color
                            child: InkWell(
                              splashColor: primaryColor, // inkwell color
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.add),
                              ),
                              onTap: () {
                                _mapController.animateCamera(
                                  CameraUpdate.zoomIn(),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ClipOval(
                          child: Material(
                            color: primaryColor, // button color
                            child: InkWell(
                              splashColor: primaryColor, // inkwell color
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(Icons.remove),
                              ),
                              onTap: () {
                                _mapController.animateCamera(
                                  CameraUpdate.zoomOut(),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
                // Show more Info

                SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: textColorWhite,
                            borderRadius: borderRadiusMedium,
                            boxShadow: [boxShadow]),
                        width: width * 0.9,
                        child: BlocBuilder<GarageListBloc, GarageListState>(
                          builder: (context, state) {
                            if (_garageShow != null) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: 40,
                                          child: ClipOval(
                                              child: _imageProfile(
                                                  _garageShow!.logoImage)),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                width: width * 0.58,
                                                padding: new EdgeInsets.only(
                                                    right: 13.0),
                                                child: Text(
                                                  _garageShow!.name,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: new TextStyle(
                                                      fontSize: fontSizeL,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: textColorBlack),
                                                ),
                                              ),
                                            ),
                                            Row(children: [
                                              Text(
                                                "ระยะทาง: " +
                                                    _garageShow!.distance
                                                        .toString(),
                                                style: new TextStyle(
                                                    fontSize: fontSizeM,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: textColorBlack),
                                              ),
                                              Text(
                                                " | ",
                                                style: new TextStyle(
                                                    fontSize: fontSizeM,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black54),
                                              ),
                                              Icon(
                                                Icons.star,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                              Text(
                                                " " +
                                                    _garageShow!.reviewStar
                                                        .toString(),
                                                style: new TextStyle(
                                                    fontSize: fontSizeM,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: textColorBlack),
                                              ),
                                            ]),
                                            Container(
                                              height: 25,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    tServiceThai + ': ',
                                                  ),
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: _garageShow!
                                                          .typeCarRepairs
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Row(
                                                          children: [
                                                            Image.asset(
                                                              tImageAsset(
                                                                  _garageShow!
                                                                      .typeCarRepairs[
                                                                          index]
                                                                      .type),
                                                              width: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            )
                                                          ],
                                                        );
                                                      }),
                                                  Text('  |   '),
                                                  ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: _garageShow!
                                                          .serviceInGarages!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Row(
                                                          children: [
                                                            Image.asset(
                                                              tImageAsset(_garageShow!
                                                                  .serviceInGarages![
                                                                      index]
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
                                                isGarageOpen(_garageShow!)
                                                // Text(
                                                //   'close',
                                                //   style: TextStyle(
                                                //       fontSize: fontSizeM,
                                                //       fontWeight:
                                                //           FontWeight.normal,
                                                //       color: textColorRed),
                                                // ),
                                                // Padding(
                                                //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                //   child: Icon(Icons.data_usage),
                                                // ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    child: TextButton(
                                      onPressed: () {
                                        navigateToGarageInfo(_garageShow!.id);
                                      },
                                      child: Text(
                                        "รายละเอียดเพิ่มเติม",
                                        style: TextStyle(
                                            fontSize: fontSizeS,
                                            color: textColorBlack),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  primaryColor),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      borderRadiusMediumOnlyBottom))),
                                    ),
                                  )
                                ],
                              );
                            }
                            return Wrap(children: <Widget>[
                              Container(
                                  alignment: Alignment.center,
                                  child: Text("เลือกร้านให้บริการ"))
                            ]);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // Show current location button
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 180.0),
                      child: ClipOval(
                        child: Material(
                          color: primaryColor,
                          child: InkWell(
                            splashColor: primaryColor, // inkwell color
                            child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(Icons.my_location),
                            ),
                            onTap: () {
                              _mapController.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(
                                      currentPosition.latitude,
                                      currentPosition.longitude,
                                    ),
                                    zoom: 14.0,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: CircularProgressIndicator(),
          ));
        },
      ),
    );
  }

  List<Marker> getMarkers(List<Garage> garages, BitmapDescriptor icon) {
    var markers = <Marker>[];

    garages.forEach((garage) {
      logger.d(
          "garage: ${garage.id}, lat: ${garage.address.geoLocation.lat}, long: ${garage.address.geoLocation.long}");
      Marker marker = Marker(
          markerId: MarkerId(garage.name),
          draggable: false,
          icon: icon,
          infoWindow: InfoWindow(title: garage.name),
          onTap: () {
            setState(() {
              _garageShow = garage;
              logger.d("Marker Tap garageId: ${garage.id}");
              // _garageListBloc.add(ShowGarageInfo(garage: _garageShow));
            });
            //_garage = garage;
          },
          position: LatLng(double.parse(garage.address.geoLocation.lat),
              double.parse(garage.address.geoLocation.long)));

      markers.add(marker);
    });

    return markers;
  }

  _imageProfile(String image) {
    if (image == '') {
      return Image.asset(
        tImageAsset(image),
        width: 110,
        height: 150,
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        image,
        width: 110,
        height: 150,
        fit: BoxFit.cover,
      );
    }
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

  void navigateToGarageInfo(String garageId) {
    Navigator.pushNamed(context, GARAGE_INFO_ROUTE,
        arguments: {'garageId': garageId});
  }

  // Method for retrieving the current location
  // _getCurrentLocation() async {
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     setState(() {
  //       currentPosition = position;
  //       print('CURRENT POS: $currentPosition');
  //       _mapController.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(position.latitude, position.longitude),
  //             zoom: 16.0,
  //           ),
  //         ),
  //       );
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
}
