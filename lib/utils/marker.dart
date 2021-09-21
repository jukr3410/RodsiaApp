import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';

class MarkerService {
  List<Marker> getMarkers(List<Garage> garages) {
    var markers = <Marker>[];

    garages.forEach((garage) {
      Marker marker = Marker(
          markerId: MarkerId(garage.name),
          draggable: false,
          infoWindow: InfoWindow(title: garage.name, snippet: garage.phone),
          position: LatLng(double.parse('garage.address.geoLocation.lat'),
              double.parse('garage.address.geoLocation.long')));

      markers.add(marker);
    });

    return markers;
  }
}
