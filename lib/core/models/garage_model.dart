// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiaapp/core/models/service_in_garage_mode.dart';
import 'package:rodsiaapp/core/models/service_model.dart';

import 'geo_location_model.dart';

Garage userFromJson(String str) => Garage.fromJson(json.decode(str));

String userToJson(Garage data) => json.encode(data.toJson());

class Garage {
  Garage(
      {required this.address,
      this.openingHour,
      this.openingDayOfWeek,
      required this.images,
      required this.logoImage,
      required this.id,
      required this.name,
      required this.phone,
      this.email,
      required this.typeCarRepairs,
      this.services,
      this.serviceInGarages,
      this.reviewStar});

  Address address;
  OpeningHour? openingHour;
  OpeningDayOfWeek? openingDayOfWeek;
  List<ImageGarage> images;
  String logoImage;
  String id;
  String name;
  String phone;
  String? email;
  List<Service>? services;
  List<ServiceInGarage>? serviceInGarages;
  List<TypeCarRepairs> typeCarRepairs;
  String? reviewStar;
  String? distance;

  factory Garage.fromJson(Map<String, dynamic> json) => Garage(
      address: Address.fromJson(json["address"]),
      openingHour: OpeningHour.fromJson(json["openingHour"]),
      openingDayOfWeek: OpeningDayOfWeek.fromJson(json["openingDayOfWeek"]),
      images: List<ImageGarage>.from(
          json["images"].map((x) => ImageGarage.fromJson(x))),
      logoImage: json["logoImage"],
      id: json["_id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      reviewStar: json["reviewStar"],
      typeCarRepairs: List<TypeCarRepairs>.from(
          json["typeCarRepairs"].map((x) => TypeCarRepairs.fromJson(x))),
      serviceInGarages: List<ServiceInGarage>.from(
          json["serviceInGarages"].map((x) => ServiceInGarage.fromJson(x))),
      services: json["services"] != null
          ? List<Service>.from(json["services"].map((x) => Service.fromJson(x)))
          : []);

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "openingHour": openingHour!.toJson(),
        "openingDayOfWeek": openingDayOfWeek!.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "logoImage": logoImage,
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "typeCarRepairs":
            List<TypeCarRepairs>.from(typeCarRepairs.map((x) => x)),
      };
}

class TypeCarRepairs {
  String type;

  TypeCarRepairs({required this.type});

  factory TypeCarRepairs.fromJson(Map<String, dynamic> json) => TypeCarRepairs(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}

class ImageGarage {
  String image;

  ImageGarage({required this.image});

  factory ImageGarage.fromJson(Map<String, dynamic> json) => ImageGarage(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
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

class OpeningDayOfWeek {
  OpeningDayOfWeek({
    required this.mo,
    required this.tu,
    required this.we,
    required this.th,
    required this.fr,
    required this.sa,
    required this.su,
  });

  bool mo;
  bool tu;
  bool we;
  bool th;
  bool fr;
  bool sa;
  bool su;

  factory OpeningDayOfWeek.fromJson(Map<String, dynamic> json) =>
      OpeningDayOfWeek(
        mo: json["mo"],
        tu: json["tu"],
        we: json["we"],
        th: json["th"],
        fr: json["fr"],
        sa: json["sa"],
        su: json["su"],
      );

  Map<String, dynamic> toJson() => {
        "mo": mo,
        "tu": tu,
        "we": we,
        "th": th,
        "fr": fr,
        "sa": sa,
        "su": su,
      };
}

class OpeningHour {
  OpeningHour({
    required this.open,
    required this.close,
  });

  String open;
  String close;

  factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
        open: json["open"],
        close: json["close"],
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "close": close,
      };
}
