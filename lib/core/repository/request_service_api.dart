import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_add_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'dart:convert';
import 'package:rodsiaapp/constants.dart';
import 'package:http/http.dart' as http;
import 'package:rodsiaapp/core/models/service_model.dart';

import '../../main.dart';

class RequestServiceApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<String> createRequestService(
      {required RequestServiceAdd requestServiceAdd}) async {
    logger.d('${requestServiceAdd.toJson()}');
    final msg = jsonEncode(requestServiceAdd.toJson());
    final url = '$baseUrl/request-services';
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response.body);
      return response.body;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    String requestServiceId = decodedJson['requestServiceId'];
    return requestServiceId;
  }

  Future<RequestServiceAdd> getRequestService({required String id}) async {
    final url = '$baseUrl/request-services/$id';
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d(decodedJson);
    RequestServiceAdd requestService = RequestServiceAdd.fromJson(decodedJson);
    logger.d(requestService);
    return requestService;
  }

  Future<List<RequestService>> getRequestServiceByUserId(
      {required String id}) async {
    List<RequestService> requestServices = [];
    final url = '$baseUrl/request-services/user/$id';
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    logger.d(decodedJson);
    requestServices = decodedJson
        .map((decodedJson) => RequestService.fromJson(decodedJson))
        .toList();
    logger.d(requestServices);
    return requestServices;
  }
}
