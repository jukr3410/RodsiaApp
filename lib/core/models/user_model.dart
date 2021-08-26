// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.otp,
    required this.validatePhone,
    required this.cars,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String email;
  String phone;
  String password;
  String otp;
  bool validatePhone;
  List<Car> cars;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        otp: json["otp"],
        validatePhone: json["validatePhone"],
        cars: List<Car>.from(json["cars"].map((x) => Car.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "otp": otp,
        "validatePhone": validatePhone,
        "cars": List<dynamic>.from(cars.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Car {
  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.type,
    required this.year,
    required this.fuelType,
  });

  String id;
  String brand;
  String model;
  String type;
  String year;
  String fuelType;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["_id"],
        brand: json["brand"],
        model: json["model"],
        type: json["type"],
        year: json["year"],
        fuelType: json["fuelType"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "brand": brand,
        "model": model,
        "type": type,
        "year": year,
        "fuelType": fuelType,
      };
}
