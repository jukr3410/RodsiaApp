// To parse this JSON data, do
//
//     final requestService = requestServiceFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiaapp/core/models/garage_model.dart';

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
      required this.garage,
      required this.car,
      required this.confirmRequest,
      required this.status,
      required this.geoLocationUser,
      required this.geoLocationGarage,
      this.image,
      required this.createTime});

  String id;
  String problemDesc;
  User user;
  Service service;
  Garage garage;
  Car car;
  bool confirmRequest;
  String status;
  GeoLocation geoLocationUser;
  GeoLocation geoLocationGarage;
  String? image;
  DateTime createTime;

  factory RequestService.fromJson(Map<String, dynamic> json) => RequestService(
      id: json["_id"],
      problemDesc: json["problemDesc"],
      user: User.fromJson(json["user"]),
      service: Service.fromJson(json["service"]),
      garage: Garage.fromJson(json['garage']),
      car: Car.fromJson(json["car"]),
      confirmRequest: json["confirmRequest"],
      status: json["status"],
      geoLocationUser: GeoLocation.fromJson(json["geoLocationUser"]),
      geoLocationGarage: GeoLocation.fromJson(json["geoLocationGarage"]),
      image: json["image"],
      createTime: json["createTime"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "problemDesc": problemDesc,
        "user": user.toJson(),
        "service": service.toJson(),
        "garage": garage.toJson(),
        "car": car.toJson(),
        "confirmRequest": confirmRequest,
        "status": status,
        "geoLocationUser": geoLocationUser.toJson(),
        "geoLocationGarage": geoLocationGarage.toJson(),
        "image": image,
        "createTime": createTime
      };
}
