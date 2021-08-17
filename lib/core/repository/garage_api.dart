import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiaapp/core/models/garage_model.dart';

class GarageApi {
  //dev localhost api
  final baseUrl = "http://localhost:3000/api";

  // production api
  //final baseUrl = '';

  final http.Client httpClient;

  GarageApi({required this.httpClient});

  Future<List<Garage>> getGarages({required int page}) async {
    List<Garage> garages = [];
    final url = '$baseUrl/garages?page=$page';
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    garages =
        decodedJson.map((decodedJson) => Garage.fromJson(decodedJson)).toList();

    return garages;
  }

  Future<Garage> getGarageInfo({required String id}) async {
    final url = '$baseUrl/garage-id/$id';
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    Garage garage = decodedJson;

    return garage;
  }
}