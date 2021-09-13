import 'dart:convert';

import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/service_model.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  final baseUrl = baseUrlConstant;
  Future<List<Service>> getByGaragesName({required String garageId}) async {
    List<Service> services = [];
    final url = '$baseUrl/garage/:$garageId/services';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    services = decodedJson
        .map((decodedJson) => Service.fromJson(decodedJson))
        .toList();

    return services;
  }
}
