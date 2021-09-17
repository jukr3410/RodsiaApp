import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiaapp/constants.dart';
import 'package:rodsiaapp/core/models/services_type_model.dart';

import '../../main.dart';

class ServiceTypeApi {
  final baseUrl = baseUrlConstant;

  Future<List<ServiceType>> getServiceTypes() async {
    List<ServiceType> serviceTypes = [];
    final url = '$baseUrl/service-types';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    serviceTypes = decodedJson
        .map((decodedJson) => ServiceType.fromJson(decodedJson))
        .toList();
    return serviceTypes;
  }
}
