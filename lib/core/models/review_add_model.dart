// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

ReviewAdd reviewFromJson(String str) => ReviewAdd.fromJson(json.decode(str));

String reviewToJson(ReviewAdd data) => json.encode(data.toJson());

class ReviewAdd {
  ReviewAdd(
      {required this.id,
      required this.text,
      required this.star,
      required this.user,
      required this.garage,
      required this.requestService});

  String id;
  String text;
  int star;
  String user;
  String garage;
  String requestService;

  factory ReviewAdd.fromJson(Map<String, dynamic> json) => ReviewAdd(
      id: json["_id"],
      text: json["text"],
      star: json["star"],
      user: json["user"],
      garage: json["garage"],
      requestService: json["requestService"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "text": text,
        "star": star,
        "user": user,
        "garage": garage,
        "requestService": requestService
      };
}
