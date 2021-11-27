class Car {
  Car(
      {required this.brand,
      required this.model,
      required this.type,
      required this.year,
      required this.fuelType,
      required this.regisNumber});

  String brand;
  String model;
  String type;
  String year;
  String fuelType;
  String regisNumber;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
      brand: json["brand"],
      model: json["model"],
      type: json["type"],
      year: json["year"],
      fuelType: json["fuelType"],
      regisNumber: json['regisNumber']);

  Map<String, dynamic> toJson() => {
        "brand": brand,
        "model": model,
        "type": type,
        "year": year,
        "fuelType": fuelType,
        'regisNumber': regisNumber
      };
}
