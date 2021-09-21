import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';

class MarkerService {
  Future<List<Marker>> getMarkers(List<Garage> garages) async {
    var markers = <Marker>[];
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/car-repair.png', 100);

    garages.forEach((garage) {
      Marker marker = Marker(
          markerId: MarkerId(garage.name),
          draggable: false,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(title: garage.name, snippet: garage.phone),
          position: LatLng(double.parse('garage.address.geoLocation.lat'),
              double.parse('garage.address.geoLocation.long')));

      markers.add(marker);
    });

    return markers;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
