import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/services/geo_location_service.dart';
import 'package:rodsiaapp/core/services/marker.dart';
import 'package:rodsiaapp/main.dart';

class MoreInfoGaragePage extends StatefulWidget {
  final Garage garage;
  MoreInfoGaragePage({Key? key, required this.garage}) : super(key: key);

  @override
  _MoreInfoGarageState createState() => _MoreInfoGarageState();
}

class _MoreInfoGarageState extends State<MoreInfoGaragePage> {
  late GoogleMapController _mapController;
  List<Marker> markers = <Marker>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getMarkers(widget.garage);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: setAppBar(),
        backgroundColor: textColorWhite,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: 220,
                  width: double.infinity,
                  color: primaryColor,
                  child: Center(
                    child: GoogleMap(
                      scrollGesturesEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              double.parse(
                                  widget.garage.address.geoLocation.lat),
                              double.parse(
                                  widget.garage.address.geoLocation.long)),
                          zoom: 15.0),
                      myLocationEnabled: false,
                      myLocationButtonEnabled: false,
                      mapType: MapType.terrain,
                      //myLocationButtonEnabled: false,
                      zoomGesturesEnabled: false,
                      markers: Set<Marker>.of(markers),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.garage.name,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "ตำแหน่ง",
              style:
                  TextStyle(fontSize: fontSizeL, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.garage.address.addressDesc.toString(),
              style:
                  TextStyle(fontSize: fontSizeL, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "เวลาให้บริการ",
              style:
                  TextStyle(fontSize: fontSizeL, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 5,
            ),
            serviceTime(),
          ]),
        )));
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Container(
        child: GFButton(
          type: GFButtonType.transparent,
          textStyle: TextStyle(
              fontSize: 18, color: textColorBlack, fontWeight: FontWeight.bold),
          child: Text(tMoreInfoGarage),
          onPressed: () {
            logger.d(tMoreInfoGarage);
          },
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: iconColorBlack,
        ),
        onPressed: () {
          navigateToGarageInfo();
        },
      ),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.add, color: iconColorBlack),
        //   onPressed: () {},
        //   iconSize: 30.0,
        // ),
      ],
    );
  }

  serviceTime() {
    var timeMo =
        "${widget.garage.openingHour!.open} - ${widget.garage.openingHour!.close}";
    var timeTu =
        "${widget.garage.openingHour!.open} - ${widget.garage.openingHour!.close}";
    var timeWe =
        "${widget.garage.openingHour!.open} - ${widget.garage.openingHour!.close}";
    var timeTh =
        "${widget.garage.openingHour!.open} - ${widget.garage.openingHour!.close}";
    var timeFr =
        "${widget.garage.openingHour!.open} - ${widget.garage.openingHour!.close}";
    var timeSa =
        "${widget.garage.openingHour!.open} - ${widget.garage.openingHour!.close}";
    var timeSu =
        "${widget.garage.openingHour!.open} - ${widget.garage.openingHour!.close}";
    if (widget.garage.openingDayOfWeek!.mo == false) {
      timeMo = "ปิด";
    }
    if (widget.garage.openingDayOfWeek!.mo == false) {
      timeTu = "ปิด";
    }
    if (widget.garage.openingDayOfWeek!.tu == false) {
      timeWe = "ปิด";
    }
    if (widget.garage.openingDayOfWeek!.we == false) {
      timeTh = "ปิด";
    }
    if (widget.garage.openingDayOfWeek!.th == false) {
      timeFr = "ปิด";
    }
    if (widget.garage.openingDayOfWeek!.fr == false) {
      timeSa = "ปิด";
    }
    if (widget.garage.openingDayOfWeek!.sa == false) {
      timeSu = "ปิด";
    }

    return Text(
      '''
จันทร์   ${timeMo}
อังคาร   ${timeTu}
พุธ   ${timeWe}
พฤหัสบดี   ${timeTh}
ศุกร์   ${timeFr}
เสาร์   ${timeSa}
อาทิตย์   ${timeSu}
''',
      maxLines: 20,
      style: TextStyle(fontSize: fontSizeL, fontWeight: FontWeight.normal),
    );
  }

  List<Marker> getMarkers(Garage garage) {
    var markers = <Marker>[];

    logger.d(
        "garage: ${garage.id}, lat: ${garage.address.geoLocation.lat}, long: ${garage.address.geoLocation.long}");
    Marker marker = Marker(
        markerId: MarkerId(garage.name),
        draggable: false,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: garage.name),
        position: LatLng(double.parse(garage.address.geoLocation.lat),
            double.parse(garage.address.geoLocation.long)));

    markers.add(marker);

    setState(() {
      this.markers = markers;
    });

    return markers;
  }

  navigateToGarageInfo() {
    Navigator.pop(context);
  }
}
