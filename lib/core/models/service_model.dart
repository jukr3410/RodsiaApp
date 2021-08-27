// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/services_type_model.dart';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.serviceType,
    required this.garage,
  });

  String id;
  String name;
  String description;
  ServiceType serviceType;
  Garage garage;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        serviceType: ServiceType.fromJson(json["serviceType"]),
        garage: Garage.fromJson(json["garage"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "serviceType": serviceType.toJson(),
        "garage": garage.toJson(),
      };
}
