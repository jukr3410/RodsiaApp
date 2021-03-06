import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locally/locally.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/distance_matrix.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'package:rodsiaapp/core/repository/request_service_repository.dart';
import 'package:rodsiaapp/global_widgets/supportButton.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/trackingRequestCard.dart';

import '../../main.dart';

class TrackingRequestPage extends StatefulWidget {
  RequestService req;
  TrackingRequestPage({Key? key, required this.req}) : super(key: key);

  @override
  _TrackingRequestPageState createState() => _TrackingRequestPageState();
}

class _TrackingRequestPageState extends State<TrackingRequestPage> {
  late GoogleMapController _mapController;
  late RequestServiceBloc _requestServiceBloc;

  late LatLng currentPosition;
  late LatLng destinationPosition;

  List<LatLng> latlongs = [];
  BitmapDescriptor? customIcon1;
  List<Marker> markers = <Marker>[];

  PolylinePoints polylinePoints = PolylinePoints();
  List<Polyline> polyline = [];

  late DistanceMatrix _distanceMatrix;

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(TrackingRequestService(requestServiceId: widget.req.id));
    currentPosition = LatLng(double.parse(widget.req.geoLocationUser.lat),
        double.parse(widget.req.geoLocationUser.long));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title:
            Container(alignment: Alignment.centerRight, child: SupportButton()),
      ),
      // bottomNavigationBar: Container(
      //   width: double.infinity,
      //   height: 45,
      //   color: primaryColor,
      //   child: Text(tInSeriveThai),
      //   alignment: Alignment.center,
      // ),
      backgroundColor: bgColor,
      body: BlocConsumer<RequestServiceBloc, RequestServiceState>(
        listener: (context, state) {
          if (state is RequestServiceLoading) {
            createMarker(context);
          } else if (state is RequestServiceLoadSuccess) {
            if (widget.req.status != state.requestService.status) {
              showMessage(state.requestService.status);
            }
            widget.req = state.requestService;
            _distanceMatrix = state.distanceMatrix!;
            setState(() {});

            destinationPosition = LatLng(
                double.parse(state.requestService.geoLocationGarage.lat),
                double.parse(state.requestService.geoLocationGarage.long));
            latlongs = [];
            latlongs.add(currentPosition);
            latlongs.add(destinationPosition);

            markers = getMarkers(latlongs, customIcon1!);
            getPolyline(latlongs);
          } else if (state is RequestServiceComleted) {
            navigateToRequestComplated(widget.req);
          }
        },
        builder: (context, state) {
          if (state is RequestServiceInService) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: currentPosition, zoom: 14.0),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  mapType: MapType.normal,
                  //myLocationButtonEnabled: false,
                  zoomGesturesEnabled: true,
                  polylines: Set<Polyline>.of(polyline),
                  markers: Set<Marker>.of(markers),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                // Show current location button
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 300.0),
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
                                    target: currentPosition,
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
                SizedBox(
                  height: 10.0,
                ),
                SafeArea(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TrackingRequestCard(
                              req: widget.req,
                              duration: ((_distanceMatrix
                                          .rows[0].elements[0].duration.value /
                                      60))
                                  .toStringAsFixed(0),
                              distance: (_distanceMatrix
                                          .rows[0].elements[0].distance.value ~/
                                      1000)
                                  .toStringAsFixed(1),
                            ))))
              ],
            );
          }
          return Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ));
        },
      ),
    );
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

  List<Marker> getMarkers(List<LatLng> latlongs, BitmapDescriptor icon) {
    var markers = <Marker>[];
    BitmapDescriptor setIcon = BitmapDescriptor.defaultMarker;

    latlongs.forEach((latlong) {
      logger.d("latlong: ${latlong.toString()}");
      if (latlong.latitude != currentPosition.latitude) {
        setIcon = icon;
      }
      Marker marker = Marker(
          markerId: MarkerId(latlong.toString()),
          draggable: false,
          icon: setIcon,
          onTap: () {},
          position: latlong);

      markers.add(marker);
    });
    return markers;
  }

  void getPolyline(List<LatLng> latlongs) async {
    //var polyline = <Polyline>[];

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "map api",
      PointLatLng(currentPosition.latitude, currentPosition.longitude),
      PointLatLng(destinationPosition.latitude, destinationPosition.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      logger.e(result.errorMessage);
    }

    polyline.add(Polyline(
      polylineId: PolylineId("route"),
      geodesic: true,
      points: polylineCoordinates,
      width: 5,
      color: textColorBlack,
    ));
  }

  navigateToRequestComplated(RequestService? requestService) {
    Navigator.pushReplacementNamed(context, REQUEST_COMPLETE_ROUTE,
        arguments: {'requestService': requestService});
  }

  showMessage(String message) {
    Locally locally;

    locally = Locally(
      context: context,
      payload: 'test',
      pageRoute: MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (BuildContext context) => RequestServiceBloc(
                  requestServiceRepository: RequestServiceRepository()),
              child: TrackingRequestPage(req: widget.req))),
      appIcon: 'mipmap/ic_launcher',
    );
    locally.show(title: "???????????????????????????????????????????????????", message: "??????????????? $message");
  }
}
