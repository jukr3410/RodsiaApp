// To parse this JSON data, do
//
//     final requestService = requestServiceFromJson(jsonString);

import 'dart:convert';

import 'garage_model.dart';

import 'car_model.dart';
import 'geo_location_model.dart';
import 'service_model.dart';
import 'user_model.dart';

RequestService requestServiceFromJson(String str) =>
    RequestService.fromJson(json.decode(str));

String requestServiceToJson(RequestService data) => json.encode(data.toJson());

class RequestService {
  RequestService(
      {required this.id,
      required this.problemDesc,
      required this.user,
      required this.service,
      required this.car,
      required this.confirmRequest,
      required this.status,
      required this.addressUser,
      required this.geoLocationUser,
      required this.geoLocationGarage,
      this.images,
      required this.createdAt});

  String id;
  String problemDesc;
  User user;
  Service service;
  Car car;
  bool confirmRequest;
  String status;
  String addressUser;
  GeoLocation geoLocationUser;
  GeoLocation geoLocationGarage;
  List<ImageGarage>? images;
  DateTime createdAt;

  factory RequestService.fromJson(Map<String, dynamic> json) => RequestService(
        id: json["_id"],
        problemDesc: json["problemDesc"],
        user: User.fromJson(json["user"]),
        service: Service.fromJson(json["service"]),
        car: Car.fromJson(json["car"]),
        confirmRequest: json["confirmRequest"],
        status: json["status"],
        addressUser: json['addressUser'],
        geoLocationUser: GeoLocation.fromJson(json["geoLocationUser"]),
        geoLocationGarage: GeoLocation.fromJson(json["geoLocationGarage"]),
        images: List<ImageGarage>.from(
            json["images"].map((x) => ImageGarage.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "problemDesc": problemDesc,
        "user": user.toJson(),
        "service": service.toJson(),
        "car": car.toJson(),
        "confirmRequest": confirmRequest,
        "status": status,
        "addressUser": addressUser,
        "geoLocationUser": geoLocationUser.toJson(),
        "geoLocationGarage": geoLocationGarage.toJson(),
        "images": List<dynamic>.from(images!.map((x) => x)),
        "createdAt": createdAt
      };
}
