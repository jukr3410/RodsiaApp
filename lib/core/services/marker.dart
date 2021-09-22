import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/main.dart';

class MarkerService {
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
            logger.d("Tab location: ${garage.id}");
          },
          position: LatLng(double.parse(garage.address.geoLocation.lat),
              double.parse(garage.address.geoLocation.long)));

      markers.add(marker);
    });

    return markers;
  }
}
