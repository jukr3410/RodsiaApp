import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/dao/user_dao.dart';
import 'package:rodsiaapp/core/models/garage_model.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:rodsiaapp/core/models/user_model_db.dart';
import 'package:rodsiaapp/core/repository/user_repository.dart';
import 'package:rodsiaapp/core/services/geo_location_service.dart';
import 'package:rodsiaapp/main.dart';
import 'package:rodsiaapp/core/repository/service_api.dart';

class GarageApi {
  final baseUrl = baseUrlConstant;

  final userDao = UserDao();

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final geoService = GeoLocatorService();

  Future<List<Garage>> getGarages(
      {required int page, FilterGarageModel? filter}) async {
    UserDB userToken = await userDao.getUserToken();
    logger.d('userToken phone: ${userToken.phone}');
    logger.d('userToken id: ${userToken.user_id}');

    // headers.update("authorization", (value) => '$token');
    final position = await geoService.getLocation();

    List<Garage>? garages = [];
    List<Service> services = [];
    final url =
        '$baseUrl/garages/q?page=$page&limit=10&carType=${filter!.carType}&serviceType=${filter.serviceType}&lat=${position.latitude}&long=${position.longitude}';
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      print('Exception: ${response.statusCode}');
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;

    garages =
        decodedJson.map((decodedJson) => Garage.fromJson(decodedJson)).toList();

    for (var garage in garages) {
      final distanceMatrix = await this.geoService.getDistanceMatrix(
          startLatitude: position.latitude,
          startLongitude: position.longitude,
          endLatitude: double.parse(garage.address.geoLocation.lat),
          endLongitude: double.parse(garage.address.geoLocation.long));

      garages[garages.indexOf(garage)].distance =
          distanceMatrix.rows[0].elements[0].distance.text;

      logger.d("serviceInGarage: ${garage.serviceInGarages!.first.name}");

      //logger.d("garage: ${garage.services}");
    }

    logger.d(garages);
    return garages;
  }

  Future<List<Garage>> getByGaragesName({required String name}) async {
    List<Garage> garages = [];

    final position = await geoService.getLocation();

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

      // cal distance
      final distanceMatrix = await this.geoService.getDistanceMatrix(
          startLatitude: position.latitude,
          startLongitude: position.longitude,
          endLatitude: double.parse(garages[i].address.geoLocation.lat),
          endLongitude: double.parse(garages[i].address.geoLocation.long));

      garages[i].distance = distanceMatrix.rows[0].elements[0].distance.text;
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
