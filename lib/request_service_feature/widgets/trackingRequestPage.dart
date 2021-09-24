import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/request_service_feature/bloc/request_service_bloc.dart';
import 'package:rodsiaapp/request_service_feature/widgets/trackingRequestCard.dart';

class TrackingRequestPage extends StatefulWidget {
  String requestServiceId;
  TrackingRequestPage({Key? key, required this.requestServiceId})
      : super(key: key);

  @override
  _TrackingRequestPageState createState() => _TrackingRequestPageState();
}

class _TrackingRequestPageState extends State<TrackingRequestPage> {
  late GoogleMapController _mapController;
  late RequestServiceBloc _requestServiceBloc;

  late Position currentPosition;

  late RequestServiceAdd _requestServiceAdd;

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(TrackingRequestService(requestServiceId: widget.requestServiceId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerRight,
          child: GFButton(
            type: GFButtonType.transparent,
            textStyle: TextStyle(fontSize: 14, color: textColorBlack),
            child: Text(tSupportThai),
            onPressed: () {},
          ),
        ),
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
          if (state is RequestServiceLoadSuccess) {
            _requestServiceAdd = state.requestServiceAdd;
          } else if (state is RequestServiceComleted) {
            navigateToRequestComplated(_requestServiceAdd.id);
          }
        },
        builder: (context, state) {
          if (state is RequestServiceInService) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(13.652744, 100.4859621), zoom: 14.0),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  //myLocationButtonEnabled: false,
                  zoomGesturesEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
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
                                    target: LatLng(13.652744, 100.4859621),
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
                                requestServiceAdd: _requestServiceAdd))))
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

  navigateToRequestComplated(String? requestServiceId) {
    Navigator.pushReplacementNamed(context, REQUEST_COMPLETE_ROUTE,
        arguments: {'requestServiceId': requestServiceId});
  }
}
