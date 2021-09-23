import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/main.dart';

class GarageApi {
  final baseUrl = baseUrlConstant;

  //late final http.Client httpClient;

  //GarageApi({required this.httpClient});

  Future<List<Garage>> getGarages({required int page}) async {
    List<Garage> garages = [];
    final url = '$baseUrl/garages?page=$page&limit=10';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      print('Exception: ${response.statusCode}');
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    garages =
        decodedJson.map((decodedJson) => Garage.fromJson(decodedJson)).toList();

    return garages;
  }

  Future<List<Garage>> getByGaragesName(
      {required int page, required String name}) async {
    List<Garage> garages = [];
    final url = '$baseUrl/garages-name/:$name?page=$page';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    garages =
        decodedJson.map((decodedJson) => Garage.fromJson(decodedJson)).toList();

    return garages;
  }

  Future<Garage> getGarageInfo({required String id}) async {
    final url = '$baseUrl/garages-id/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);

    Garage garage = Garage.fromJson(decodedJson);
    logger.d(garage);
    return garage;
  }
}
