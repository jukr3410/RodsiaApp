import 'dart:convert';

import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:http/http.dart' as http;
import 'package:rodsiaapp/main.dart';

class ServiceApi {
  final baseUrl = baseUrlConstant;

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<List<Service>> getServiceByGarage({required String garageId}) async {
    List<Service> services = [];
    final url = '$baseUrl/garage/$garageId/services';
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

    return services;
  }

  Future<Service> getServiceById({required String serviceId}) async {
    Service services;
    final url = '$baseUrl/services-id/$serviceId';
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d("services: $decodedJson");
    services = Service.fromJson(decodedJson);

    return services;
  }
}
