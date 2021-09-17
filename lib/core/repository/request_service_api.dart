import 'package:rodsiaapp/core/models/geo_location_model.dart';
import 'package:rodsiaapp/core/models/request_service_model.dart';
import 'dart:convert';
import 'package:rodsiaapp/constants.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class RequestServiceApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<bool> createRequestService(
      {required RequestService requestService}) async {
    logger.d('${requestService.toJson()}');
    final msg = jsonEncode(requestService.toJson());
    final url = '$baseUrl/request-services';
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<RequestService> getRequestService({required String id}) async {
    final url = '$baseUrl/request-services/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    RequestService requestService = decodedJson;

    return requestService;
  }
}
