// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'car_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.otp,
      required this.validatePhone,
      required this.cars,
      this.profileImage});

  String id;
  String name;
  String email;
  String phone;
  String password;
  String otp;
  bool validatePhone;
  List<Car> cars;
  String? profileImage;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        otp: json["otp"],
        validatePhone: json["validatePhone"],
        cars: List<Car>.from(json["cars"].map((x) => Car.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "otp": otp,
        "validatePhone": validatePhone,
        "cars": List<Car>.from(cars.map((x) => x.toJson())),
      };
}
