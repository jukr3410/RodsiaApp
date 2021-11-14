import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/dao/user_dao.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/core/repository/service_api.dart';

class GarageApi {
  final baseUrl = baseUrlConstant;

  //late final http.Client httpClient;

  //GarageApi({required this.httpClient});
  final userDao = UserDao();

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<List<Garage>> getGarages({required int page}) async {
    // UserDB token = await userDao.getToken(0);
    // headers.update("Authorization", (value) => 'Bearer $token');
    List<Garage>? garages = [];
    final url = '$baseUrl/garages?page=$page&limit=10';
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      print('Exception: ${response.statusCode}');
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    garages =
        decodedJson.map((decodedJson) => Garage.fromJson(decodedJson)).toList();
    for (var i = 0; i < garages.length; i++) {
      List<Service> services = [];
      final url = '$baseUrl/garage/${garages[i].id}/services';
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        logger.e(response);
        throw new Exception('There was a problem ${response.statusCode}');
      }
      final decodedJson = jsonDecode(response.body) as List;
      logger.d("services: $decodedJson");
      services = decodedJson
          .map((decodedJson) => Service.fromJson(decodedJson))
          .toList();
      garages[i].services = services;
    }
    logger.d(garages);
    return garages;
  }

  Future<List<Garage>> getByGaragesName(
      {required String name}) async {
    List<Garage> garages = [];
    final url = '$baseUrl/garages-name/$name';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    garages =
        decodedJson.map((decodedJson) => Garage.fromJson(decodedJson)).toList();
    for (var i = 0; i < garages.length; i++) {
      List<Service> services = [];
      final url = '$baseUrl/garage/${garages[i].id}/services';
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode != 200) {
        logger.e(response);
        throw new Exception('There was a problem ${response.statusCode}');
      }
      final decodedJson = jsonDecode(response.body) as List;
      logger.d("services: $decodedJson");
      services = decodedJson
          .map((decodedJson) => Service.fromJson(decodedJson))
          .toList();
      garages[i].services = services;
    }
    return garages;
  }

  Future<Garage> getGarageInfo({required String id}) async {
    List<Service> services = [];

    final url = '$baseUrl/garages-id/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);

    Garage garage = Garage.fromJson(decodedJson);

    final urlService = '$baseUrl/garage/${garage.id}/services';
    final responseService =
        await http.get(Uri.parse(urlService), headers: headers);
    if (responseService.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJsonService = jsonDecode(responseService.body) as List;
    services = decodedJsonService
        .map((decodedJsonService) => Service.fromJson(decodedJsonService))
        .toList();
    garage.services = services;

    logger.d(garage);
    return garage;
  }
}
