// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/services_type_model.dart';

ServiceInGarage serviceFromJson(String str) =>
    ServiceInGarage.fromJson(json.decode(str));

//String serviceToJson(ServiceInGarage data) => json.encode(data.toJson());

class ServiceInGarage {
  ServiceInGarage({
    required this.id,
    required this.name,
    this.description,
    required this.serviceType,
  });

  String id;
  String name;
  String? description;
  ServiceType serviceType;

  factory ServiceInGarage.fromJson(Map<String, dynamic> json) =>
      ServiceInGarage(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        serviceType: ServiceType.fromJson(json["serviceType"]),
      );
}
