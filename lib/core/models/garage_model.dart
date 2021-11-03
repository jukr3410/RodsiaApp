// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiaapp/core/models/service_model.dart';

import 'geo_location_model.dart';

Garage userFromJson(String str) => Garage.fromJson(json.decode(str));

String userToJson(Garage data) => json.encode(data.toJson());

class Garage {
  Garage(
      {required this.address,
      this.openingHour,
      required this.images,
      this.logoImage,
      required this.id,
      required this.name,
      required this.phone,
      this.email,
      required this.services});

  Address address;
  OpeningHour? openingHour;
  List<String> images;
  String? logoImage;
  String id;
  String name;
  String phone;
  String? email;
  List<Service> services;

  factory Garage.fromJson(Map<String, dynamic> json) => Garage(
        address: Address.fromJson(json["address"]),
        openingHour: OpeningHour.fromJson(json["openingHour"]),
        images: List<String>.from(json["images"].map((x) => x)),
        logoImage: json["logoImage"],
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        services: List<Service>.from(json["services"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "openingHour": openingHour!.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "logoImage": logoImage,
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "services": List<dynamic>.from(services.map((x) => x))
      };
}

class Address {
  Address({
    required this.geoLocation,
    this.addressDesc,
  });

  GeoLocation geoLocation;
  String? addressDesc;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        geoLocation: GeoLocation.fromJson(json["geoLocation"]),
        addressDesc: json["addressDesc"],
      );

  Map<String, dynamic> toJson() => {
        "geoLocation": geoLocation.toJson(),
        "addressDesc": addressDesc,
      };
}

class OpeningHour {
  OpeningHour({
    required this.mo,
    required this.tu,
    required this.we,
    required this.th,
    required this.fr,
    required this.sa,
    required this.su,
  });

  Day mo;
  Day tu;
  Day we;
  Day th;
  Day fr;
  Day sa;
  Day su;

  factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
        mo: Day.fromJson(json["mo"]),
        tu: Day.fromJson(json["tu"]),
        we: Day.fromJson(json["we"]),
        th: Day.fromJson(json["th"]),
        fr: Day.fromJson(json["fr"]),
        sa: Day.fromJson(json["sa"]),
        su: Day.fromJson(json["su"]),
      );

  Map<String, dynamic> toJson() => {
        "mo": mo.toJson(),
        "tu": tu.toJson(),
        "we": we.toJson(),
        "th": th.toJson(),
        "fr": fr.toJson(),
        "sa": sa.toJson(),
        "su": su.toJson(),
      };
}

class Day {
  Day({
    required this.open,
    required this.close,
  });

  String open;
  String close;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        open: json["open"],
        close: json["close"],
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "close": close,
      };
}
