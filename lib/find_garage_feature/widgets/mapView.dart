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

  final List<Garage> _garages = [];
  List<Marker> markers = <Marker>[];

  BitmapDescriptor? customIcon1;

  Garage? _garage;

  @override
  void initState() {
    super.initState();
    _garageListBloc = BlocProvider.of<GarageListBloc>(context)
      ..add(GetCurrentLocation())
      ..add(GarageListFetchEvent());
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
          } else if (state is MapError) {
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
          } else if (state is GarageListSuccessState) {
            _garages.addAll(state.garages);
            markers = getMarkers(_garages, customIcon1!);
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
                  zoomGesturesEnabled: true,
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            boxShadow: [boxShadow]),
                        width: width * 0.9,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Icon(
                                          Icons.store_outlined,
                                          size: 32,
                                        ),
                                      ),
                                      Flexible(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 15,
                                          bottom: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _garage != null
                                                  ? _garage!.name
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: fontSizeXl,
                                                  color: textColorBlack),
                                            ),
                                            Text(
                                              _garage != null
                                                  ? _garage!.phone
                                                  : "",
                                              maxLines: 2,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: textColorBlack),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_garage != null) {
                                        navigateToGarageInfo(_garage!.id);
                                      } else {}
                                    },
                                    child: Text(
                                      "รายละเอียดเพิ่มเติม",
                                      style: TextStyle(
                                          fontSize: fontSizeM,
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
                                              BorderRadius.circular(10),
                                        ))),
                                  ),
                                )
                              ],
                            )),
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
            _garage = garage;
            logger.d("Marker Tap garageId: ${_garage!.id}");
          },
          position: LatLng(double.parse(garage.address.geoLocation.lat),
              double.parse(garage.address.geoLocation.long)));

      markers.add(marker);
    });

    return markers;
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
